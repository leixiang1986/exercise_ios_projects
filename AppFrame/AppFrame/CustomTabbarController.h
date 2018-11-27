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

static NSString *const kTabBarDefaultImageKey   = @"TabBarDefaultImageKey";
static NSString *const kTabBarHighlightImageKey = @"TabBarHighlightImageKey";
static NSString *const kTabBarTitleKey          = @"TabBarTitleKey";

@class CustomTabbarController;
@protocol CustomTabbarControllerDelegate <NSObject>
@optional
- (BOOL)tabbarController:(CustomTabbarController *)tabbarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabbarController:(CustomTabbarController *)tabbarController didSelectViewController:(UIViewController *)viewController;
- (void)tabbarController:(CustomTabbarController *)tabbarController didUnselectViewController:(UIViewController *)viewController;

@end

@interface CustomTabbarController : BaseViewController
@property(nullable, nonatomic,copy) NSArray<__kindof BaseViewController *> *viewControllers;
@property(nullable, nonatomic, assign) __kindof BaseViewController *selectedViewController;
@property(nonatomic) NSUInteger selectedIndex;

@property(nonatomic,strong ,readonly) UITabBar *tabBar;

@property (nonatomic, weak) id<CustomTabbarControllerDelegate>delegate;

- (instancetype)initWithViewControllers:(NSArray *)viewControllers withTabBarInfos:(NSArray *)tabBarInfos NS_DESIGNATED_INITIALIZER;

@end

@interface BaseViewController (CustomTabbarController)
@property (nonatomic, strong, readonly) CustomTabbarController *customTabBarController;
@end

@interface CustomTabBar : UITabBar
@property (nonatomic, strong, readonly) NSArray *infos;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame withInfos:(NSArray *)infos NS_DESIGNATED_INITIALIZER;
@end

NS_ASSUME_NONNULL_END
