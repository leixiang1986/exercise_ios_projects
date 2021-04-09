//
//  NSObject+Dealloc.m
//  TestProject
//
//  Created by leixiang on 2021/4/9.
//

#import "NSObject+Dealloc.h"
#import <objc/runtime.h>

/// 此为一 寄生类
@interface Parasite : NSObject
@property (nonatomic, copy) void(^deallocBlock)(void);
@end

@implementation Parasite

- (void)dealloc {
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}
@end

@implementation NSObject (Dealloc)
- (void)addDeallocCallback:(void(^)(void))callback {
    @synchronized (self) {
        static NSString *kAssociateKey = @"kAssociateKey";
        NSMutableArray *parasiteList = objc_getAssociatedObject(self, &kAssociateKey);
        if (parasiteList == nil) {
            parasiteList = [[NSMutableArray alloc] init];
            objc_setAssociatedObject(self, &kAssociateKey, parasiteList, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        /// 创建寄生类 存放block
        Parasite *parasite = [Parasite new];
        parasite.deallocBlock = callback;
        [parasiteList addObject: parasite];
    }
}
@end
