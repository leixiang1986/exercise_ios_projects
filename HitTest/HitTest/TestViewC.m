//
//  TestViewC.m
//  HitTest
//
//  Created by leixiang on 2018/11/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TestViewC.h"

@implementation TestViewC

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"%@ %s,返回:%@",NSStringFromClass([self class]),__func__,view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"%@ %s,返回:%d",NSStringFromClass([self class]),__func__,isInside);
    return isInside;
}

@end
