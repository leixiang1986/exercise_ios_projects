//
//  FMDBManager.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager : NSObject

@property (nonatomic, assign, readonly) NSInteger version;
@property (nonatomic, strong, readonly) FMDatabase *db;
@property (nonatomic, strong, readonly) FMDatabaseQueue *dbQueue;

+ (instancetype)shareManager;


@end

NS_ASSUME_NONNULL_END
