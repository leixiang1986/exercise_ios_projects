//
//  SubCategoryObj+Exchange2.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SubCategoryObj+Exchange2.h"
#import "NSObject+Runtime.h"

@implementation SubCategoryObj (Exchange2)
+ (void)load {
    [self swizzleInstanceMethod:@selector(exchange) withMethod:@selector(myExchange) forClass:[self class]];
}

- (void)myExchange {
    NSLog(@"这是子类扩展2的MyExchange方法");
    [self myExchange];
}


@end
