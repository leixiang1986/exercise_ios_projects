//
//  Person+Test.h
//  CategoryExcercise
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Person.h"
#import "Test.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (Test)
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) Test *test;
@end

NS_ASSUME_NONNULL_END
