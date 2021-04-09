//
//  ManagerA.m
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import "ManagerA.h"

@interface ManagerA ()
//@property (nonatomic, strong) NSHashTable *listeners;
@end

@implementation ManagerA
static dispatch_once_t onceToken;
static ManagerA *instance = nil;
+ (instancetype)shareInstance {
    dispatch_once(&onceToken, ^{
        instance = [[ManagerA alloc] init];
    });
    return instance;
}

- (void)destroyInstance {
    instance = nil;
    onceToken = 0;
}

- (void)addListener:(id)object {
    if (object == nil) {
        return;
    }
    [self.listeners addObject:object];
}

- (void)removeListener:(id)object {
    NSLog(@"将要移除:%@",object);
#warning 问题点
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (object == nil) {
            return;
        }
        NSLog(@"ManagerA removeListener");
        for (id obj in self.listeners.allObjects) {
            if (obj == object) {
                [self.listeners removeObject:object];
            }
        }
    });
    
}

- (NSHashTable *)listeners {
    if (!_listeners) {
        _listeners = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsWeakMemory) capacity:2];
    }
    return _listeners;
}

- (void)dealloc {
    NSLog(@"ManagerA dealloc:%ld",self.listeners.count);
    
}

@end
