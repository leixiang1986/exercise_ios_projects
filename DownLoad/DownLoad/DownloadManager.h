//
//  DownloadManager.h
//  DownLoad
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadManager : NSObject
+ (instancetype)shareManager;

- (NSURLSessionTask *)downloadWithURL:(NSURL *)url progress:(CGFloat)progress complete:(void(^)(NSString *location))complete;


@end

NS_ASSUME_NONNULL_END
