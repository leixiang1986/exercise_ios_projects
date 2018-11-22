//
//  SecondViewController.m
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SecondViewController.h"
#import "NSBundle+Language.h"
#import <objc/message.h>
#import "CustomView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"是否重新开始");
    object_setClass(self.view, [CustomView class]);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    label.text = NSLocalizedString(@"Test", nil);
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    NSLog(@"%@",self.view);
}


@end
