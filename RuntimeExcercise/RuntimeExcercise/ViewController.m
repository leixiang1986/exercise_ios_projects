//
//  ViewController.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self changeInstanceClass];
    [self callUnreconglizeMechod];
}

//替换实例的类
- (void)changeInstanceClass {
    object_setClass(self.view, [CustomView class]);
    NSLog(@"%@",self.class);
}

//解决实例和类没有的方法(类中复写实现)
- (void)callUnreconglizeMechod {
    [self.view performSelector:@selector(enene)];
    [CustomView performSelector:@selector(hehe)];
}


@end
