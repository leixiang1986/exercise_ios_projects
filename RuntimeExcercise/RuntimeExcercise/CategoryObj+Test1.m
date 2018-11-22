//
//  CategoryObj+Test1.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CategoryObj+Test1.h"

@implementation CategoryObj (Test1)
+ (void)load {
    NSLog(@"CategoryObj Test1中的load");
}

- (void)categoryMethod1 {
    NSLog(@"Categoryobj 1 method");
}

- (void)test {
    NSLog(@"test1 中的test方法");
}

@end
