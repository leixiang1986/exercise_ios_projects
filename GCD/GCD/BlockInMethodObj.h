//
//  BlockInMethodObj.h
//  GCD
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlockInMethodObj : NSObject
- (void)testWithBlock:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
