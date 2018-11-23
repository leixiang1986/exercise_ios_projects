//
//  NSObject+Runtime.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)
+ (void)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector forClass:(Class)class
{
    
    Method originalMethod = class_getClassMethod(class, origSelector);
    Method swizzledMethod = class_getClassMethod(class, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(class).UTF8String);
    if (class_addMethod(metacls,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* swizzing super class method, added if not exist */
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector  forClass:(Class)class
{
//    Class cls = [self class];
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod(class, origSelector);
    Method swizzledMethod = class_getInstanceMethod(class, newSelector);
    /* add selector if not exist, implement append with method */
    if (class_addMethod(class,
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod(class,newSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));

    } else {
//         swizzleMethod maybe belong to super
        class_replaceMethod(class,
                            newSelector,
                            class_replaceMethod(class,
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
//        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
