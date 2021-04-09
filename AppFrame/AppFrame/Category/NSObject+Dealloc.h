//
//  NSObject+Dealloc.h
//  TestProject
//
//  Created by leixiang on 2021/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Dealloc)
- (void)addDeallocCallback:(void(^)(void))callback;
@end

NS_ASSUME_NONNULL_END
