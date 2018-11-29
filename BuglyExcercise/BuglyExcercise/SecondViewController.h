//
//  SecondViewController.h
//  BuglyExcercise
//
//  Created by leixiang on 2018/11/29.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondViewController : ViewController
@property (nonatomic, copy) void(^block)(void);
@end

NS_ASSUME_NONNULL_END
