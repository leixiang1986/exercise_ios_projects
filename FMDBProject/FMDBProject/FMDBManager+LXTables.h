//
//  FMDBManager+LXTables.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager (LXTables)
- (BOOL)createMatchTableInDB:(FMDatabase *)db;
- (BOOL)createTextLiveTableInDB:(FMDatabase *)db;
@end

NS_ASSUME_NONNULL_END
