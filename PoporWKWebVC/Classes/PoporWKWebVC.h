//
//  PoporWKWebVC.h
//  PoporWKWebVC
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WKWebView;
@class PoporWKWebVC;

@interface PoporWKWebVC : UIViewController

@property (nonatomic, strong) NSString  * firstUrl;
@property (nonatomic, strong) NSMutableURLRequest * firstRequest;

@property (nonatomic, strong) WKWebView * infoWV;
@property (nonatomic, copy  ) void (^viewDidLoadBlock)(PoporWKWebVC *webVC);

- (id)initWithTitle:(NSString *)title url:(NSString *)url;
- (id)initWithTitle:(NSString *)title request:(NSMutableURLRequest *)request;


@end

