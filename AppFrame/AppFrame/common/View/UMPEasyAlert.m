//
//  UMPEasyAlert.m
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/13.
//  Copyright © 2021 UMP. All rights reserved.
//

#import "UMPEasyAlert.h"

@implementation UMPEasyAlert
/// UIAlertController的便利访问方式
/// @param title 标题
/// @param content 内容
/// @param cancelBlock 取消回调
/// @param confirmBlock 确认回调
+ (UIAlertController *)showAlertWithTitle:(NSString *)title
                              content:(NSString *)content
                               cancel:(UMPVoidBlock)cancelBlock
                              confirm:(UMPVoidBlock)confirmBlock {
    /// 为title为nil时不显示，为@""时显示默认标题
    NSString *cancelTitle = cancelBlock == nil ? nil : @"";
    NSString *confirmTitle = confirmBlock == nil ? nil : @"";
    return [self showAlertWithTitle:title
                            content:content
                        cancelTitle:cancelTitle
                             cancel:cancelBlock
                       confirmTitle:confirmTitle
                            confirm:confirmBlock];
}

/// UIAlertController的便利访问方式
/// @param title 标题
/// @param content 内容
/// @param cancelBlock 取消回调
/// @param confirmBlock 确认回调
+ (UIAlertController *)showAlertWithTitle:(nullable NSString *)title
                                  content:(nullable NSString *)content
                              cancelTitle:(nullable NSString *)cancelTitle
                                   cancel:(nullable UMPVoidBlock)cancelBlock
                             confirmTitle:(nullable NSString *)confirmTitle
                                  confirm:(nullable UMPVoidBlock)confirmBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:(UIAlertControllerStyleAlert)];
    
    NSString *cancelStr = cancelTitle.length ? cancelTitle : Klocalize(@"cancelTitle");
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelStr style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock();
        }
    }];
    
    NSString *confirmStr = confirmTitle.length ? confirmTitle : Klocalize(@"OK");
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmStr style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (confirmBlock) {
            confirmBlock();
        }
    }];
    
    if (cancelTitle != nil) {
        [alert addAction:cancel];
    }
    if (confirmTitle != nil) {
        [alert addAction:confirm];
    }
    
    [[WakeApp getCurrentController] presentViewController:alert animated:YES completion:nil];
    return alert;
}

@end
