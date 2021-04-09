//
//  ManagerB.h
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerB : NSObject
+ (instancetype)shareInstance;
- (void)destroyInstance;
@end

NS_ASSUME_NONNULL_END
