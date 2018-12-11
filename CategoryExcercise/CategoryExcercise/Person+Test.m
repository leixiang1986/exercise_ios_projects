//
//  Person+Test.m
//  CategoryExcercise
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Person+Test.h"
#import <objc/runtime.h>

@implementation Person (Test)

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY);
    
    
}

- (NSString *)name {
   return objc_getAssociatedObject(self, @selector(name));
}

- (void)setObj:(id)obj {
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)obj {
    return objc_getAssociatedObject(self, @selector(obj));
}

- (void)setTest:(Test *)test {
    //创建子类
//    Class SubTest = objc_allocateClassPair(object_getClass(test), "SubTest", 0);
    
    objc_setAssociatedObject(self, @selector(test), test, OBJC_ASSOCIATION_COPY);
}

- (Test *)test {
    return objc_getAssociatedObject(self, @selector(test));
}


@end
