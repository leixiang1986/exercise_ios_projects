//
//  TestBaseView.m
//  HitTest
//
//  Created by leixiang on 2021/4/9.
//  Copyright © 2021 admin. All rights reserved.
//

#import "TestBaseView.h"

@implementation TestBaseView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"%@ %s,返回:%@",self.name,__func__,view);
    if ([self.name isEqualToString:@"viewC"]) {
        return self;
    }
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"%@ %s,返回:%d",self.name,__func__,isInside);
//    if ([self.name isEqualToString:@"viewC"]) {
//        return NO;
//    }
    return isInside;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@_%s",self.name,__func__);
}

@end
