//
//  CategoryObj+Exchange2.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CategoryObj+Exchange2.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation CategoryObj (Exchange2)
+ (void)load {
    [self swizzleInstanceMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(dealloc2) forClass:[self class]];
}

- (void)dealloc2 {
    NSLog(@"exchange2 中的dealloc");
    [self dealloc2];
}

@end
