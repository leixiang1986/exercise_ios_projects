//
//  CustomTabbarController.h
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class CustomTabbarController;
@protocol CustomTabbarControllerDelegate <NSObject>
@optional
- (BOOL)tabbarController:(CustomTabbarController *)tabbarController willSelectViewController:(UIViewController *)viewController;
- (void)tabbarController:(CustomTabbarController *)tabbarController didSelectViewController:(UIViewController *)viewController;
- (void)tabbarController:(CustomTabbarController *)tabbarController didUnselectViewController:(UIViewController *)viewController;

@end


@interface CustomTabbarController : BaseViewController
@property(nullable, nonatomic,copy) NSArray<__kindof BaseViewController *> *viewControllers;
@property(nullable, nonatomic, assign) __kindof BaseViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

@property(nonatomic,readonly) UITabBar *tabBar;

@property (nonatomic, weak) id<CustomTabbarControllerDelegate>delegate;
@property (nonatomic, strong, readonly) CustomTabbarController *tabBarController;

@end

@interface BaseViewController (CustomTabbarController)
@property (nonatomic, strong, readonly) CustomTabbarController *customTabBarController;
@end

NS_ASSUME_NONNULL_END
