//
//  SubCategoryObj.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SubCategoryObj.h"

@implementation SubCategoryObj

+ (void)load {
    NSLog(@"SubCategoryObj 中的load");
}

//不用调用super的initialize方法，会自动调用
+ (void)initialize {
    [super initialize];
    NSLog(@"SubCategoryObj 中的initialize");
}

- (void)test {
    NSLog(@"SubCategoryObj 中的test方法");
}

//- (void)dealloc {
//    NSLog(@"SubCategoryObj dealloc");
//}

@end
