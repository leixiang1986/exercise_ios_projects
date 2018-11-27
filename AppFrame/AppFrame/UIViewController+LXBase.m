//
//  UIViewController+LXBase.m
//  AppFrame
//
//  Created by leixiang on 2018/11/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIViewController+LXBase.h"
#import <objc/runtime.h>

@implementation UIViewController (LXBase)
@dynamic reenterable;
- (void)setReenterable:(BOOL)able {
    objc_setAssociatedObject(self, @selector(reenterable), @(able), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)reenterable {
    return [objc_getAssociatedObject(self, @selector(reenterable)) boolValue];
}

@end
