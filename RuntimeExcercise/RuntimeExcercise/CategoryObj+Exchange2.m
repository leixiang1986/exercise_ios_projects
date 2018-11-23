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
    [self swizzleInstanceMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(dealloc1)];
}

- (void)dealloc1 {
    NSLog(@"exchange2 中的dealloc");
    [self dealloc1];
}


@end
