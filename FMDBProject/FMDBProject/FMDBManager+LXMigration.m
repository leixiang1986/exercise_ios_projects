//
//  FMDBManager+LXMigration.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager+LXMigration.h"

@implementation FMDBManager (LXMigration)
- (BOOL)upgradeToVersion2:(FMDatabase *)db {
    NSLog(@"升级到版本2");
    return YES;
}
@end
