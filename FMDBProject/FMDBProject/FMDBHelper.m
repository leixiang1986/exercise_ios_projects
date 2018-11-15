//
//  FMDBHelper.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBHelper.h"
#import "FMDBManagerConst.h"

@interface FMDBHelper ()

@end

@implementation FMDBHelper

+ (NSDictionary *)getTableNameMethodMaps {
    return @{kMatchTable:@"createMatchTableInDB:",
             kTextLiveTable:@"createTextLiveTableInDB:"
             };
}

//+ (NSArray *)getTableNames {
//    return @[kMatchTable, kTextLiveTable];
//}

@end
