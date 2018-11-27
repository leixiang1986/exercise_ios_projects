//
//  CustomNavigationController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomNavigationController.h"
#import "UIViewController+LXBase.h"

@interface CustomNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation CustomNavigationController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarStyle:(UIBarStyleBlackTranslucent)];
    [navigationBar setBarTintColor:[UIColor lightGrayColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    //在BaseViewController中去除掉返回的按钮 self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //如果类型可重入或者不是同一种类型的控制器才可以push
    if ([viewController isMemberOfClass:[self.viewControllers.lastObject class]] && !viewController.reenterable) {
        NSAssert(NO, @"相同类型，不可重入");
        return ;
    }
    
    if (self.viewControllers.count > 0) {
        SEL backSel = NSSelectorFromString(@"backButtonClick:");
        UIBarButtonItem *backItem = nil;
        if ([viewController respondsToSelector:backSel]) {
            backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back_white_normal"] style:(UIBarButtonItemStylePlain) target:viewController action:backSel];
        } else {
            backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back_white_normal"] style:(UIBarButtonItemStylePlain) target:viewController action:@selector(popViewControllerAnimated:)];
        }
        viewController.navigationItem.leftBarButtonItem = backItem;
        //如果用原生的tabBarController，需要设置
//        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//当手势开始滑动作用：拦截手势触发
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //子控制器个数只剩下一个(这一个就是根控制器),手势不可用
    BOOL open = self.childViewControllers.count != 1;
    return open;
}

@end
