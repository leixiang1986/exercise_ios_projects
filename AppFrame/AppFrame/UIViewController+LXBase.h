//
//  UIViewController+LXBase.h
//  AppFrame
//
//  Created by leixiang on 2018/11/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LXBase)
@property (nonatomic, assign, getter=isReenterable) BOOL reenterable;
@end

NS_ASSUME_NONNULL_END
