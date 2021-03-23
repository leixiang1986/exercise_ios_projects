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
///不能手势返回,默认为NO，即默认可以手势返回
@property (nonatomic, assign) BOOL notPanPop;
///将要手势返回时的block
@property (nonatomic, copy) void(^gestureShouldPopBlock)(void);

//子类可自定义
- (void)backButtonClick:(id)sender NS_REQUIRES_SUPER;
///修改CustomNavigationController的导航栏效果
- (void)setupNaviBarWhiteBarBlackTitleMainItem;
@end

NS_ASSUME_NONNULL_END
