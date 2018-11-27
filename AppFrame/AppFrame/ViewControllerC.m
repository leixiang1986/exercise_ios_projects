//
//  ViewControllerC.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewControllerC.h"
#import "ViewControllerD.h"
#import "LXViewConsts.h"

@interface ViewControllerC ()

@end

@implementation ViewControllerC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"vc_C";
    self.view.backgroundColor = [UIColor cyanColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, kScreenWidth - 20, 200)];
    label.numberOfLines = 0;
    label.text = @"测试导航栏隐藏，滑动返回导航栏是否随pushedViewController滑动：除了C控制器设置导航栏的显示隐藏，还需要设置被push的D控制器的显示";
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(100, 100, 100, 60);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"点击跳转" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)buttonClick:(id)sender {
    ViewControllerD *vcD = [[ViewControllerD alloc] init];
    [self.navigationController pushViewController:vcD animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end
