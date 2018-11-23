//
//  SubCategoryObj+Exchange1.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SubCategoryObj+Exchange1.h"
#import "NSObject+Runtime.h"

@implementation SubCategoryObj (Exchange1)
+ (void)load {
    [self swizzleInstanceMethod:@selector(exchange) withMethod:@selector(myExchange) forClass:[self class]];
}

- (void)myExchange {
    NSLog(@"这是子类扩展1的MyExchange方法");
    [self myExchange];
}
@end
