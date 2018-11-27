//
//  CustomNavigationController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarStyle:(UIBarStyleBlackOpaque)];
    [navigationBar setBarTintColor:[UIColor lightGrayColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    
}



@end
