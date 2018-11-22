//
//  CustomView.m
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomView.h"
#import <objc/runtime.h>

@implementation CustomView

- (void)didMoveToWindow {
    NSLog(@"%s",__func__);
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    NSLog(@"%s",__func__);
}

- (void)willRemoveSubview:(UIView *)subview {
    NSLog(@"%s",__func__);
}

- (void)didMoveToSuperview {那个
    NSLog(@"%s",__func__);
}

//解决实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    IMP imp = class_getMethodImplementation([self class], @selector(callNotImplementMethod));
    class_addMethod([self class], sel, imp, "V:@");
    return YES;
//    return [super resolveInstanceMethod:sel];
}

void haha () {
    NSLog(@"访问了一个不存在的函数！");
}

- (void)callNotImplementMethod {
    NSLog(@"访问了没有的方法");
}

@end
