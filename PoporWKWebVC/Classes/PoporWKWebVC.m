//
//  PoporWKWebVC.m
//  PoporWKWebVC
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "PoporWKWebVC.h"

#import <WebKit/WebKit.h>
#import <PoporUI/IToastKeyboard.h>

@interface PoporWKWebVC ()<WKUIDelegate, WKNavigationDelegate>

@end

@implementation PoporWKWebVC

- (id)initWithTitle:(NSString *)title url:(NSString *)url; {
    if (self = [super init]) {
        self.title    = title;
        self.firstUrl = url;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title request:(NSMutableURLRequest *)request {
    if (self = [super init]) {
        self.title        = title;
        self.firstRequest = request;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
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
        if (self.navigationController) {
            CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];//标题栏
            CGRect NavRect    = self.navigationController.navigationBar.frame;//然后将高度相加，便可以动态计算顶部高度。
            CGFloat height    = StatusRect.size.height + NavRect.size.height;
            
            if (self.navigationController.navigationBar.translucent) {
                self.infoWV.frame = CGRectMake(0, height, self.view.frame.size.width, self.view.frame.size.height - height);
            }else{
                self.infoWV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - height);
            }
        }else{
            self.infoWV.frame = self.view.bounds;
        }
        
        
        if (@available(iOS 11, *)) {
            self.infoWV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        if (self.firstRequest) {
            [self.infoWV loadRequest:self.firstRequest];
        }else{
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.firstUrl]];
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

