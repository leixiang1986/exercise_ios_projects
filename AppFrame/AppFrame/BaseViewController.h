//
//  BaseViewController.h
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LXBase.h"
@class CustomTabbarController;
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL isOnScreen;
@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, weak) CustomTabbarController *customTabBarController;

//子类可自定义
- (void)backButtonClick:(id)sender NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
