//
//  FMDBHelper.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBHelper : NSObject

+ (NSDictionary *)getTableNameMethodMaps;
//+ (NSArray *)getTableNames;

@end

NS_ASSUME_NONNULL_END
