//
//  UMPAuthorizationTool.h
//  UMP-Doctor
//
//  Created by LeiXiang on 2021/3/13.
//  Copyright © 2021 UMP. All rights reserved.
//
///权限便利访问工具类
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UMPAuthorizationCallback)(BOOL result);
@interface UMPAuthorizationTool : NSObject


///查询设备权限状态(同步返回状态)
+ (AVAuthorizationStatus)checkDediaAuthorizationWithType:(AVMediaType)type;

/// 查看多媒体权限,如果没有获得允许，会异步请求许可
/// @param type 权限类型
/// @param tips 没权限时是否提示
/// @param complete 完成回调
+ (void)chechAuthorizationWithType:(AVMediaType)type
                            tips:(BOOL)tips
                            complete:(UMPAuthorizationCallback)complete;

@end

NS_ASSUME_NONNULL_END
