//
//  NSObject+extension.m
//  消息发送流程
//
//  Created by LeiXiang on 2021/9/11.
//

#import "NSObject+extension.h"

@implementation NSObject (extension)
#pragma mark - 消息方法的封装
/// 将字符串转化为selector
/// @param selectorStr 执行的方法
/// @param params 方法的参数
/// @param callback 执行后要执行的方法名(这个是可选看具体需求设置)
- (void)performSelectorWithString:(NSString *)selectorStr parameters:(NSDictionary *)params callback:(NSString *)callback {
    SEL selector = NSSelectorFromString(selectorStr);
    if (![self respondsToSelector:selector]) {
        return;
    }
    IMP imp = [self methodForSelector:selector];
    ///转化类型
    if (params && callback) {
        void (*func)(id,SEL,id,id) = (void *)imp;
        ///执行方法
        func(self,selector,params,callback);
    } else if (params) {
        void (*func)(id,SEL,id) = (void *)imp;
        ///执行方法
        func(self,selector,params);
    } else {
        void (*func)(id,SEL) = (void *)imp;
        ///执行方法
        func(self,selector);
    }
    
}
@end
