//
//  LXTextLive.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXTextLive : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger textID;
@property (nonatomic, assign) NSInteger matchID;
@end

NS_ASSUME_NONNULL_END
