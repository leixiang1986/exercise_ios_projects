//
//  BaseViewController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

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

- (void)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (CustomTabbarController *)tabBarController {
    NSLog(@"后去了自定义的tabBarController");
    return self.customTabBarController;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isOnScreen = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isOnScreen = NO;
}

@end
