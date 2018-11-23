//
//  SubTestObject.h
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubTestObject : TestObject
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) void (^block)(void);
@end

NS_ASSUME_NONNULL_END
