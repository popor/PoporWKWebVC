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
        [self initInteractors];
        
    }
    return self;
}

// 一般由present初始化使用或者继承使用.
- (void)initInteractors {
    if (!self.interactor) {
        self.interactor = [PoporWKWebVCInteractor new];
    }
}

// 很多操作,需要在设置了view之后才可以执行.
- (void)setMyView:(id<PoporWKWebVCProtocol>)view {
    self.view = view;
}

#pragma mark - VC_DataSource

#pragma mark - VC_EventHandler

#pragma mark - Interactor_EventHandler

@end
