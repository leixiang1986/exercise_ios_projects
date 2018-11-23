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
+ (void)load {
    SEL dellocSEL = NSSelectorFromString(@"dealloc");
    
    [self swizzleInstanceMethod:dellocSEL withMethod:@selector(dealloc1) forClass:[self class]];

}

//+(void)load{
//    //    Method oriMethod = class_getInstanceMethod([self class], @selector(dealloc));
//
//    Method oriMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
//    Method repMethod = class_getInstanceMethod([self class], @selector(replaceDelloc));
//    method_exchangeImplementations(oriMethod, repMethod);
//}
- (void)replaceDelloc{
    NSLog(@"delloc被替换了");
}

- (void)dealloc1 {
    NSLog(@"exchange1 中的dealloc");
    [self dealloc1];
}






@end
