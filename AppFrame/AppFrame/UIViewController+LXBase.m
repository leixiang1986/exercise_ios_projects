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
@dynamic reEnterable;
- (void)setReEnterable:(BOOL)able {
    objc_setAssociatedObject(self, @selector(reEnterable), @(able), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)reEnterable {
    return [objc_getAssociatedObject(self, @selector(reEnterable)) boolValue];
}

@end
