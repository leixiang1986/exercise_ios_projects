//
//  CategoryObj+Test2.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CategoryObj+Test2.h"

@implementation CategoryObj (Test2)
+ (void)load {
    NSLog(@"CategoryObj Test2中的load");
}

- (void)categoryMethod2 {
    NSLog(@"Categoryobj 2 method");
}

- (void)test {
    NSLog(@"test2 中的test方法");
}
@end
