//
//  UMPAuthorityTool.m
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/13.
//  Copyright © 2021 UMP. All rights reserved.
//

#import "UMPAuthorizationTool.h"
#import "UMPEasyAlert.h"

@implementation UMPAuthorizationTool

#pragma mark - 音频视频的权限
+ (AVAuthorizationStatus)checkDediaAuthorizationWithType:(AVMediaType)type {
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

/// 查看多媒体权限,如果没有获得允许，会异步请求许可
/// @param type 权限类型
/// @param tips 没权限时是否提示
/// @param complete 完成回调
+ (void)chechAuthorizationWithType:(AVMediaType)type
                            tips:(BOOL)tips
                            complete:(UMPAuthorizationCallback)complete {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:type];
    if (status == AVAuthorizationStatusAuthorized) { ///已经授权
        !complete ?: complete(YES);
    } else if (status == AVAuthorizationStatusDenied){ ///已经拒绝
        ///显示提示信息，点击后再返回无权限状态
        if (tips) {
            [self showMediaTipsWithType:type click:^{
                !complete ?: complete(NO);
            }];
        } else {
            !complete ?: complete(NO);
        }
    } else if (status == AVAuthorizationStatusNotDetermined) { ///未申请授权
        ///申请授权
        [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) { ///申请时同意
                    !complete ?: complete(YES);
                } else { ///申请权限不同意
                    if (tips) {
                        [self showMediaTipsWithType:type click:^{
                            complete ?: complete(NO);
                        }];
                    } else {
                        complete ?: complete(NO);
                    }
                }
            });
        }];
    }
}

+ (void)showMediaTipsWithType:(AVMediaType)type click:(UMPVoidBlock)click{
    NSString *msg = [self mediaNoAuthorizationMessageOfType:type];
    if (msg.length == 0) {
        !click ?: click();
        return;
    }
    [UMPEasyAlert showAlertWithTitle:@"提示" content:msg cancel:nil confirm:^{
        !click ?: click();
    }];
}

/// 没有权限的提示信息
/// @param type 多媒体权限的类型
+ (NSString *)mediaNoAuthorizationMessageOfType:(AVMediaType)type {
    if ([type isEqualToString:AVMediaTypeVideo]) {
        return @"必须允许访问相机权限才能进入视频，请前往设置->隐私->相机中打开";
    } else if ([type isEqualToString:AVMediaTypeAudio]) {
        return @"必须允许访问麦克风权限才能进入视频，请前往设置->隐私->麦克风中打开";
    }
    return @"";
}

#pragma mark - 相册权限
#warning TODO 相册权限

@end
