//
//  FMDBManager+LXTables.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager+LXTables.h"
#import "FMDBManagerConst.h"

@implementation FMDBManager (LXTables)
- (BOOL)createMatchTableInDB:(FMDatabase *)db
{
    NSError *error = nil;
    NSString *sqlStatement = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                              @"%@ INTEGER PRIMARY KEY AUTOINCREMENT, "
                              @"%@ INTEGER, "
                              @"%@ TEXT, "
                              @"%@ TEXT);",
                              kMatchTable,
                              kTableColumnId,
                              kMatchTableID,
                              kMatchTableHomeName,
                              kMatchTableAwayName];
    
    BOOL result = [db executeUpdate:sqlStatement values:nil error:&error];
    NSAssert(result, @"");
    NSAssert(error == nil, error.description);
    return result;
}

- (BOOL)createTextLiveTableInDB:(FMDatabase *)db {
    NSError *error = nil;
    NSString *sqlStatement = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                              @"%@ INTEGER PRIMARY KEY AUTOINCREMENT, "
                              @"%@ INTEGER, "
                              @"%@ INTEGER, "
                              @"%@ TEXT);",
                              kTextLiveTable,
                              kTableColumnId,
                              kTextLiveTableTextID,
                              kTextLiveTableMatchID,
                              kTextLiveTableText];
    
    BOOL result = [db executeUpdate:sqlStatement values:nil error:&error];
    NSAssert(result, @"");
    NSAssert(error == nil, error.description);
    return result;
    
}
@end
