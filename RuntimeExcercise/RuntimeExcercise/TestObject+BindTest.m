//
//  TestObject+BindTest.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TestObject+BindTest.h"
#import <objc/runtime.h>

@implementation TestObject (BindTest)
- (void)setName:(NSString *)name {
//    [self willChangeValueForKey:@"name"];
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY);
//    [self didChangeValueForKey:@"name"];
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}

- (void)setBlock:(void (^)(void))block {
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY);
}

- (void (^)(void))block {
    return objc_getAssociatedObject(self, @selector(block));
}

@end
