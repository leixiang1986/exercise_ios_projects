//
//  Person.h
//  BlockDemo
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) void(^block)(void);
@end

NS_ASSUME_NONNULL_END
