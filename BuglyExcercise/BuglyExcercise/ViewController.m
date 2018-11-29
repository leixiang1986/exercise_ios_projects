//
//  ViewController.m
//  BuglyExcercise
//
//  Created by leixiang on 2018/11/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"点击发送通知" forState:(UIControlStateNormal)];
    [self.view addSubview:btn];
}

- (void)btnClick:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TestNotification" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}


@end
