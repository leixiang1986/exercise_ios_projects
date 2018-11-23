//
//  NSObject+Runtime.h
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)
+ (void)swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector forClass:(Class)cls;
+ (void)swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector forClass:(Class)cls;
@end

NS_ASSUME_NONNULL_END
