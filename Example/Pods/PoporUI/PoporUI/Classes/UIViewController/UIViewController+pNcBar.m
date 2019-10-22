//
//  UIViewController+pNcBar.m
//  PoporUI
//
//  Created by popor on 2018/6/19.
//  Copyright © 2018年 popor. All rights reserved.
//

#import "UIViewController+pNcBar.h"
#import <objc/runtime.h>

@implementation UIViewController (pNcBar)
@dynamic hiddenNcBar;

- (void)setHiddenNcBar:(BOOL)hiddenNcBar {
    objc_setAssociatedObject(self, @"hiddenNcBar", @(hiddenNcBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hiddenNcBar {
    NSNumber * n = objc_getAssociatedObject(self, @"hiddenNcBar");
    return n.boolValue;
}

- (BOOL)isInNC {
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if (vc == self) {
            return YES;
        }
    }
    return NO;
}

@end
