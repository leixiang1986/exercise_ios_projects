//
//  SubTestObject.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SubTestObject.h"

@implementation SubTestObject

- (void)setAge:(NSInteger)age {
    if (_age != age) {
        _age = age;
    }
}

- (void)setBlock:(void (^)(void))block {
    _block = block;
}

@end
