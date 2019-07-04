//
//  PoporWKWebVC.m
//  Pods
//
//  Created by apple on 2019/6/24.
//  

#import "PoporWKWebVC.h"
#import "PoporWKWebVCPresenter.h"
#import "PoporWKWebVCInteractor.h"

#import <WebKit/WebKit.h>
#import <PoporUI/IToastKeyboard.h>
#import <Masonry/Masonry.h>

@interface PoporWKWebVC () <WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) PoporWKWebVCPresenter * present;

@end

@implementation PoporWKWebVC
@synthesize infoWV;
@synthesize rootUrl;
@synthesize rootRequest;
@synthesize viewDidLoadBlock;


- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        if (dic) {
            self.title = dic[@"title"];
            self.rootUrl         = dic[@"rootUrl"];
            self.rootRequest     = dic[@"rootRequest"];
            self.viewDidLoadBlock = dic[@"viewDidLoadBlock"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [self assembleViper];
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 参考: https://www.jianshu.com/p/c244f5930fdf
    if (self.isViewLoaded && !self.view.window) {
        // self.view = nil;//当再次进入此视图中时能够重新调用viewDidLoad方法
        
    }
}

#pragma mark - VCProtocol
- (UIViewController *)vc {
    return self;
}

#pragma mark - views
- (void)assembleViper {
    if (!self.present) {
        PoporWKWebVCPresenter * present = [PoporWKWebVCPresenter new];
        PoporWKWebVCInteractor * interactor = [PoporWKWebVCInteractor new];
        
        self.present = present;
        [present setMyInteractor:interactor];
        [present setMyView:self];
        
        [self addViews];
    }
}

- (void)addViews {
    [self addWebView];
    
    if(self.viewDidLoadBlock){
        self.viewDidLoadBlock(self);
    }
}

- (void)addWebView {
    if (!self.infoWV) {
        self.infoWV = [[WKWebView alloc] init];
        self.infoWV.navigationDelegate = self;
        self.infoWV.allowsBackForwardNavigationGestures = YES;
        
        [self.view addSubview:self.infoWV];
        [self.infoWV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        if (@available(iOS 11, *)) {
            self.infoWV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }else{
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        
        if (self.rootRequest) {
            [self.infoWV loadRequest:self.rootRequest];
        }else{
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.rootUrl]];
            [self.infoWV loadRequest:request];
        }
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //NSLog(@"PoporWKWebVC request:%@, type: %i", navigationAction.request.URL.absoluteString, (int)navigationAction.navigationType);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if([error code] == NSURLErrorCancelled)  {
        return;
    }
    if (error) {
        AlertToastTitleTime(error.localizedDescription, 2);
    }
}

// 设定VC.title,和侧滑GR的开关
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.title = webView.title;
}

@end
