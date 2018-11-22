//
//  BlockInMethodObj.m
//  GCD
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "BlockInMethodObj.h"

@implementation BlockInMethodObj
- (void)testWithBlock:(void(^)(void))block {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self invokeBlock:block];
    });
}

- (void)invokeBlock:(void(^)(void))block {
    if (block) {
        block();
    }
//    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self invokeBlock:block];
    });
}

- (void)dealloc {
    NSLog(@"Block in  method obj dealloc");
}
@end
