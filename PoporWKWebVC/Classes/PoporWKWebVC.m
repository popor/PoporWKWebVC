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

@property (nonatomic        ) BOOL lastLeftItemsSupplementBackButton;
@property (nonatomic        ) BOOL lastInteractivePopGestureRecognizerEnabled;


@property (nonatomic) BOOL         isShowCloseBT;
@property (nonatomic) CGFloat      ncBarHeight;
@property (nonatomic) UIEdgeInsets safeAreaInset;

@end

@implementation PoporWKWebVC

- (id)initWithTitle:(NSString *)title url:(NSString *)url; {
    if (self = [super init]) {
        self.title      = title;
        self.firstUrl   = url;
        self.closeTitle = @"关闭";
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationItem.leftItemsSupplementBackButton                 = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //NSLog(@"viewDidAppear: %i,%i", self.lastLeftItemsSupplementBackButton, self.lastInteractivePopGestureRecognizerEnabled);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.navigationItem.leftItemsSupplementBackButton                 = self.lastLeftItemsSupplementBackButton;
    self.navigationController.interactivePopGestureRecognizer.enabled = self.lastInteractivePopGestureRecognizerEnabled;
    //NSLog(@"viewDidDisappear: %i,%i", self.lastLeftItemsSupplementBackButton, self.lastInteractivePopGestureRecognizerEnabled);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.lastLeftItemsSupplementBackButton          = self.navigationItem.leftItemsSupplementBackButton;
    self.lastInteractivePopGestureRecognizerEnabled = self.navigationController.interactivePopGestureRecognizer.enabled;
    //NSLog(@"viewDidLoad: %i,%i", self.lastLeftItemsSupplementBackButton, self.lastInteractivePopGestureRecognizerEnabled);
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
        
        self.infoWV.frame = self.view.bounds;
        if (@available(iOS 11, *)) {
            self.infoWV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.firstUrl]];
        [self.infoWV loadRequest:request];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //NSLog(@"PoporWKWebVC request:%@, type: %i", navigationAction.request.URL.absoluteString, (int)navigationAction.navigationType);
    if (navigationAction.navigationType == WKNavigationTypeBackForward) {
        [self addCloseBT];
    }
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

#pragma mark - PoporNC 返回判断
- (BOOL)shouldHoldPopEvent {
    NSLog(@"%s", __func__);
    return YES;
}

- (BOOL)canPopViewControllerByButton {
    NSLog(@"%s",  __func__);
    if ([self.infoWV canGoBack]) {
        [self.infoWV goBack];
        [self addCloseBT];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 关闭按钮
- (void)addCloseBT {
    if (!self.isShowCloseBT) {
        self.isShowCloseBT = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.closeTitle) {
                self.closeTitle = @"close";
            }
            UIBarButtonItem *itemWifi = [[UIBarButtonItem alloc] initWithTitle:self.closeTitle style:UIBarButtonItemStyleDone target:self action:@selector(closeSelfVC)];
            self.navigationItem.leftBarButtonItem = itemWifi;
        });
    }
}

- (void)closeSelfVC {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end

