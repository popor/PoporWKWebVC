//
//  PoporWKWebVCPresenter.m
//  Pods
//
//  Created by apple on 2019/6/24.
//  

#import "PoporWKWebVCPresenter.h"
#import "PoporWKWebVCInteractor.h"

@interface PoporWKWebVCPresenter ()

@property (nonatomic, weak  ) id<PoporWKWebVCProtocol> view;
@property (nonatomic, strong) PoporWKWebVCInteractor * interactor;

@end

@implementation PoporWKWebVCPresenter

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

// 初始化数据处理
- (void)setMyInteractor:(PoporWKWebVCInteractor *)interactor {
    self.interactor = interactor;
    
}

// 很多操作,需要在设置了view之后才可以执行.
- (void)setMyView:(id<PoporWKWebVCProtocol>)view {
    self.view = view;
    
}

#pragma mark - VC_DataSource

#pragma mark - VC_EventHandler

#pragma mark - Interactor_EventHandler

@end
