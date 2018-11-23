//
//  TestObject+BindTest.h
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "TestObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestObject (BindTest)
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) void (^block)(void);
@end

NS_ASSUME_NONNULL_END
