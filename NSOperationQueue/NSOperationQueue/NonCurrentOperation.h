//
//  NonCurrentOperation.h
//  NSOperationQueue
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NonCurrentOperation : NSOperation
- (instancetype)initWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
