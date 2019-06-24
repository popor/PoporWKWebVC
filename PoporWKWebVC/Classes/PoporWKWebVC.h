//
//  PoporWKWebVC.h
//  Pods
//
//  Created by apple on 2019/6/24.
//  

#import <UIKit/UIKit.h>
#import "PoporWKWebVCProtocol.h"

@interface PoporWKWebVC : UIViewController <PoporWKWebVCProtocol>

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
