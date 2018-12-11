//
//  Test.m
//  CategoryExcercise
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Test.h"

@implementation Test

- (id)copyWithZone:(NSZone *)zone
{
    Test *test = [[Test alloc] init];
    test.age = 100;
    return test;
}

- (void)dealloc {
    NSLog(@"%p dealloc",self);
}

@end
