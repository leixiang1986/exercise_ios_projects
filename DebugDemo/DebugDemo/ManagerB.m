//
//  ManagerB.m
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import "ManagerB.h"
#import "ManagerA.h"

@implementation ManagerB
static dispatch_once_t onceToken;
static ManagerB *instance = nil;
+ (instancetype)shareInstance {
    dispatch_once(&onceToken, ^{
        instance = [[ManagerB alloc] init];
    });
    return instance;
}

- (void)destroyInstance {
    instance = nil;
    onceToken = 0;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [[ManagerA shareInstance] addListener:self];
        if ([[ManagerA shareInstance].listeners containsObject:self]) {
            NSLog(@"包含:%@",self);
        } else {
            NSLog(@"不包含");
        }
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ManagerB dealloc");
    [[ManagerA shareInstance] removeListener:self];
    [[ManagerA shareInstance] destroyInstance];
}

@end
