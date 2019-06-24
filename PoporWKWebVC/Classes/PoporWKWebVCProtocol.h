//
//  PoporWKWebVCProtocol.h
//  Pods
//
//  Created by apple on 2019/6/24.
//  

#import <UIKit/UIKit.h>

@class WKWebView;
@class PoporWKWebVC;

NS_ASSUME_NONNULL_BEGIN

// MARK: 对外接口
@protocol PoporWKWebVCProtocol <NSObject>

- (UIViewController *)vc;

// MARK: 自己的
@property (nonatomic, strong) WKWebView * infoWV;

// MARK: 外部注入的
@property (nonatomic, strong) NSString  * rootUrl;
@property (nonatomic, strong) NSMutableURLRequest * rootRequest;
@property (nonatomic, copy  ) void (^viewDidLoadBlock)(PoporWKWebVC *webVC);

@end

// MARK: 数据来源
@protocol PoporWKWebVCDataSource <NSObject>

@end

// MARK: UI事件
@protocol PoporWKWebVCEventHandler <NSObject>

@end

NS_ASSUME_NONNULL_END
