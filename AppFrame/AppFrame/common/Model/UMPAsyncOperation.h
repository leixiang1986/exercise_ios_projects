//
//  UMPAsyncOperation.h
//  HKDoctor
//
//  Created by leixiang on 2021/3/31.
//  Copyright © 2021 UMP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UMPAsyncOperation;
typedef void (^UMPAsyncBlock)(UMPAsyncOperation * __nonnull asyncOperation);

@interface UMPAsyncOperation : NSOperation
- (nonnull instancetype)initWithBlock:(nonnull UMPAsyncBlock)block;
+ (nonnull instancetype)blockOperationWithBlock:(nonnull UMPAsyncBlock)block;
- (void)complete;
@end

NS_ASSUME_NONNULL_END
