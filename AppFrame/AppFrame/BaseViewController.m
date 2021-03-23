//
//  BaseViewController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "UIImage+Extension.h"
#import "UIColor+Extension.h"
#import "Define.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isFirstAppear = YES;
    //统一设置返回按钮，去掉文字
    self.navigationItem.hidesBackButton = YES;
    //使用系统的返回按钮，没有标题
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:NULL];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isOnScreen = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isOnScreen = YES;
    WEAKSELF(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!weakSelf.notPanPop) {
            weakSelf.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
        }
        weakSelf.navigationController.interactivePopGestureRecognizer.enabled = !weakSelf.notPanPop;
    });
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //关闭主界面的右滑返回
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    if (!self.notPanPop) {
        if (self.gestureShouldPopBlock) {
            self.gestureShouldPopBlock();
        }
    }
    
    return !self.notPanPop;
}

- (void)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CustomTabbarController *)tabBarController {
    NSLog(@"后去了自定义的tabBarController");
    return self.customTabBarController;
}

///设置白色导航栏，黑色返回键，黑色标题，蓝色右侧按钮
- (void)setupNaviBarWhiteBarBlackTitleMainItem {
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItem;
    ///白色底黑色返回按钮
    UIImage *image = [[UIImage imageNamed:@"goBack"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [backItem setImage: image];

    [bar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    // 标题
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    dict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"333333"];
    [bar setTitleTextAttributes:dict];

    // 导航栏Item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemDict = [NSMutableDictionary dictionary];
    itemDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    itemDict[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"333333"];
    [item setTitleTextAttributes:itemDict forState:UIControlStateNormal];
}



@end
