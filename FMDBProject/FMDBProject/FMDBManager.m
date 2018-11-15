//
//  FMDBManager.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager.h"
#import "LXCommonConst.h"
#import "LXCommonUtils.h"
#import "FMDBHelper.h"
#import "RuntimeInvoker.h"
#import "FMDBManager+LXTables.h"
#import "FMDBManager+LXMigration.h"

static uint32_t DBVERSION  = 1;

@interface FMDBManager ()

@property (nonatomic, copy) NSString *dbPath;

@property (nonatomic, strong, readwrite) FMDatabase *db;
@property (nonatomic, strong, readwrite) FMDatabaseQueue *dbQueue;

@end

@implementation FMDBManager

static FMDBManager *instance = nil;

+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMDBManager alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dbPath = [self createDBPath];
        [self setup];
    }
    return self;
}

- (NSString *)createDBPath
{
    NSString *document = getDocumentPath();
    NSString *folder = [document stringByAppendingPathComponent:@"database"];
    [LXCommonUtils createDirectorysAtPath:folder];
    return [folder stringByAppendingPathComponent:@"test.db"];
}

- (void)setup
{
    BOOL needToCreateTable = ![[NSFileManager defaultManager] fileExistsAtPath:_dbPath];
    _db = [[FMDatabase alloc] initWithPath:_dbPath];
    _dbQueue = [[FMDatabaseQueue alloc] initWithPath:_dbPath];
    _db.logsErrors = YES;
    
    BOOL ret = [_db open];
    NSAssert(ret, @"打开失败");
    
    if (needToCreateTable) { //create table
        [self createTables];
        [_db setUserVersion:DBVERSION];
    } else {
        uint32_t oldVersion = [_db userVersion];
        if (oldVersion < DBVERSION) {
            [self upgradeOldVersion:oldVersion toVersion:DBVERSION];
        }
    }
    
}

- (BOOL)createTables
{
    __block BOOL ret = YES;
    NSDictionary *maps = [FMDBHelper getTableNameMethodMaps];
    
    [maps enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSString * obj, BOOL * _Nonnull stop) {
        NSLog(@"当前的线程:%@",[NSThread currentThread]);
        BOOL result = [[self invoke:obj arguments:@[self.db]] boolValue];
        NSAssert(result == YES,@" dm db create table error");
        ret = result && ret;
    }];
    
    return ret;
}

- (BOOL)upgradeOldVersion:(uint32_t)oldVersion toVersion:(uint32_t)newVersion
{
    BOOL ret = YES;
    
    for (uint32_t i = oldVersion + 1; i <= newVersion; i++) {
        NSString    *methodStr = [NSString stringWithFormat:@"upgradeToVersion%u:", i];
        BOOL        result = [[self invoke:methodStr arguments:@[self.db]] boolValue];
        
        NSAssert(result, @"upgrade error");
        ret = ret && result;
    }
    
    return ret;
}

- (NSInteger)version {
    return (NSInteger)DBVERSION;
}


@end
