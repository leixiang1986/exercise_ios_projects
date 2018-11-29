//
//  SecondViewController.m
//  NSNotificationExcercise
//
//  Created by leixiang on 2018/11/29.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"second";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:kADeallocedObjAddNotificationName object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:kADeallocedObjAddNotificationName object:nil];
}

- (void)notification:(NSNotification *)notification {
    NSLog(@"接收通知");
}

- (void)dealloc {
    NSLog(@"second dealloc");
}

@end
