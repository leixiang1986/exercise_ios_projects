//
//  ManagerA.h
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManagerA : NSObject
@property (nonatomic, strong) NSHashTable *listeners;

+ (instancetype)shareInstance;
- (void)destroyInstance;

- (void)addListener:(id)object;
- (void)removeListener:(id)object;
@end

NS_ASSUME_NONNULL_END
