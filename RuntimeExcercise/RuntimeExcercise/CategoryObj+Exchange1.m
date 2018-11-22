//
//  CategoryObj+Exchange1.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CategoryObj+Exchange1.h"
#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation CategoryObj (Exchange1)
//+ (void)load {
//    SEL dellocSEL = NSSelectorFromString(@"dealloc");
//    [self swizzleInstanceMethod:dellocSEL withMethod:@selector(dealloc1)];
//    [self swizzleInstanceMethod:NSSelectorFromString(@"test") withMethod:@selector(myTest)];
//}

+(void)load{
    //    Method oriMethod = class_getInstanceMethod([self class], @selector(dealloc));

    Method oriMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method repMethod = class_getInstanceMethod([self class], @selector(replaceDelloc));
    method_exchangeImplementations(oriMethod, repMethod);
}
- (void)replaceDelloc{
    NSLog(@"delloc被替换了");
}



- (void)dealloc1 {
    NSLog(@"exchange1 中的dealloc");
    [self dealloc1];
}

- (void)myTest {
    NSLog(@"执行了myTest");
    [self myTest];
}

+ (void)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
    Class cls = [self class];
    
    Method originalMethod = class_getClassMethod(cls, origSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
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

+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector
{
//    Class cls = [self class];
    /* if current class not exist selector, then get super*/
    Method originalMethod = class_getInstanceMethod([self class], origSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], newSelector);
    /* add selector if not exist, implement append with method */
    if (class_addMethod([self class],
                        origSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        /* replace class instance method, added if selector not exist */
        /* for class cluster , it always add new selector here */
        class_replaceMethod([self class],
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        /* swizzleMethod maybe belong to super */
        class_replaceMethod([self class],
                            newSelector,
                            class_replaceMethod([self class],
                                                origSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}


@end
