//
//  NSObject+extension.h
//  消息发送流程
//
//  Created by LeiXiang on 2021/9/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (extension)
/// 将字符串转化为selector
/// @param selectorStr 执行的方法
/// @param params 方法的参数
/// @param callback 执行后要执行的方法名(这个是可选看具体需求设置)
- (void)performSelectorWithString:(NSString *)selectorStr parameters:(NSDictionary *)params callback:(NSString *)callback;
@end

NS_ASSUME_NONNULL_END
