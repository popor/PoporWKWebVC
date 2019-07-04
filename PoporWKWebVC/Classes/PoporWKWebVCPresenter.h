//
//  PoporWKWebVCPresenter.h
//  Pods
//
//  Created by apple on 2019/6/24.
//  

#import <Foundation/Foundation.h>
#import "PoporWKWebVCProtocol.h"

// 处理和View事件
@interface PoporWKWebVCPresenter : NSObject <PoporWKWebVCEventHandler, PoporWKWebVCDataSource>

// 初始化数据处理
- (void)setMyInteractor:(id)interactor;

// 很多操作,需要在设置了view之后才可以执行.
- (void)setMyView:(id)view;

@end
