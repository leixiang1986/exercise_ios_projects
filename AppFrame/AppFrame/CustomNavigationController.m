//
//  CustomNavigationController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomNavigationController.h"
#import "UIViewController+LXBase.h"
#import "UIImage+Extension.h"

@interface CustomNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNavigationController

+ (void)initialize {
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
//
//    [navigationBar setBarStyle:(UIBarStyleBlackTranslucent)];
//    [navigationBar setBarTintColor:[UIColor lightGrayColor]];
//    [navigationBar setTintColor:[UIColor whiteColor]];
    //在BaseViewController中去除掉返回的按钮 self.navigationItem.hidesBackButton = YES;
    [self setupNaviBarMainStyle];
}

+ (void)setupNaviBarMainStyle {
    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.shadowImage = [UIImage dt_imageWithColor:UIColorFromHex(kCOLOR_E2E2E2)];
    /*导航栏背景色*/
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forBarMetrics:UIBarMetricsDefault];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题文字
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:dict];

    // 导航栏Item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    itemDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    itemDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //如果类型可重入或者不是同一种类型的控制器才可以push
    if ([viewController isMemberOfClass:[self.viewControllers.lastObject class]] && !viewController.reEnterable) {
        NSAssert(NO, @"相同类型，不可重入");
        return ;
    }
    
    if (self.viewControllers.count > 0) {
        SEL backSel = NSSelectorFromString(@"backButtonClick:");
        UIBarButtonItem *backItem = nil;
        UIViewController *topVC = self.topViewController;
        ///防止多种导航栏时，一个公用页面在多种当行栏中显示不同效果，返回键不能跟随改变的问题
        UIImage *oldImage = topVC.navigationItem.leftBarButtonItem.image;
        if (oldImage) {
            oldImage = [UIImage imageNamed:@"ic_back_white_normal"];
        }
        
        if ([viewController respondsToSelector:backSel]) {
            backItem = [[UIBarButtonItem alloc] initWithImage:oldImage style:(UIBarButtonItemStylePlain) target:viewController action:backSel];
        } else {
            backItem = [[UIBarButtonItem alloc] initWithImage:oldImage style:(UIBarButtonItemStylePlain) target:self action:@selector(popViewControllerAnimated:)];
        }
        viewController.navigationItem.leftBarButtonItem = backItem;
        //如果用原生的tabBarController，需要设置
//        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
