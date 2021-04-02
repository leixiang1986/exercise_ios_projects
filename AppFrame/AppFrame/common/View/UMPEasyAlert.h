//
//  UMPEasyAlert.h
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/13.
//  Copyright © 2021 UMP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
///alter的便利访问方式
@interface UMPEasyAlert : NSObject

/// UIAlertController的便利访问方式
/// @param title 标题
/// @param content 内容
/// @param cancelBlock 取消回调
/// @param confirmBlock 确认回调
+ (UIAlertController *)showAlertWithTitle:(nullable NSString *)title
                                  content:(nullable NSString *)content
                                   cancel:(nullable UMPVoidBlock)cancelBlock
                                  confirm:(nullable UMPVoidBlock)confirmBlock;

/// UIAlertController的便利访问方式
/// @param title 标题
/// @param content 内容
/// @param cancelTitle 取消的标题(使用默认标题传@"",不要取消按钮传nil)
/// @param cancelBlock 取消回调
/// @param cancelTitle 确认的标题(使用默认标题传@"",不要确认按钮传nil)
/// @param confirmBlock 确认回调
+ (UIAlertController *)showAlertWithTitle:(nullable NSString *)title
                                  content:(nullable NSString *)content
                              cancelTitle:(nullable NSString *)cancelTitle
                                   cancel:(nullable UMPVoidBlock)cancelBlock
                             confirmTitle:(nullable NSString *)confirmTitle
                                  confirm:(nullable UMPVoidBlock)confirmBlock;

@end

NS_ASSUME_NONNULL_END
