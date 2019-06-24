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

// 一般由present初始化使用或者继承使用.
- (void)initInteractors;

// 很多操作,需要在设置了view之后才可以执行.
- (void)setMyView:(id)view;

@end
