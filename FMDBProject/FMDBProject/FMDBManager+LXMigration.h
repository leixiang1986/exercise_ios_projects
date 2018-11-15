//
//  FMDBManager+LXMigration.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager (LXMigration)
- (BOOL)upgradeToVersion2:(FMDatabase *)db;
@end

NS_ASSUME_NONNULL_END
