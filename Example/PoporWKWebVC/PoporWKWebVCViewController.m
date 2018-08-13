//
//  PoporWKWebVCViewController.m
//  PoporWKWebVC
//
//  Created by wangkq on 08/13/2018.
//  Copyright (c) 2018 wangkq. All rights reserved.
//

#import "PoporWKWebVCViewController.h"

//#import <PoporWKWebVC/PoporWKWebVC.h>

#import "PoporWKWebVC.h"
@interface PoporWKWebVCViewController ()

@end

@implementation PoporWKWebVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.title = @"PoporWKWebVC";
    
    UIButton * oneBT = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake((self.view.frame.size.width - 80)/2, 80, 80, 44);
        [button setTitle:@"push" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor brownColor]];
        
        button.layer.cornerRadius = 5;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1;
        button.clipsToBounds = YES;
        
        [self.view addSubview:button];
        
        [button addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
        
        button;
    });
    UILabel * oneL = ({
        UILabel * l = [UILabel new];
        l.frame              = CGRectMake(10, CGRectGetMaxY(oneBT.frame) + 40, self.view.frame.size.width - 20, 60);
        l.backgroundColor    = [UIColor clearColor];
        l.font               = [UIFont systemFontOfSize:15];
        l.textColor          = [UIColor darkGrayColor];
        //l.textAlignment      = NSTextAlignmentCenter;

        [self.view addSubview:l];
        l;
    });
    //label.preferredMaxLayoutWidth = 100;
    [oneL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    oneL.numberOfLines =0;
    oneL.text               = @"1: Only support iPhone, Not simulator!\n2: UINavigationController must be PoporPopNC!";
    
}

- (void)btAction {
    PoporWKWebVC * vc = [[PoporWKWebVC alloc] initWithTitle:@"" url:@"https://www.163.com"];
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
