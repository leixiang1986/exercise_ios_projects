//
//  FMDBManager+LXMatchTest.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager+LXMatchTest.h"
#import "FMDBManagerConst.h"

@implementation FMDBManager (LXMatchTest)
- (void)saveMatch:(LXMatch *)match
{
    if (match == nil) {
        return;
    }
    
    
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        
        BOOL ret = NO;
        NSError *error = nil;
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@=?;",kMatchTable,kMatchTableID];
        FMResultSet *resultSet = [db executeQuery:selectSql values:@[@(match.matchId)] error:&error];
        
        if (resultSet.next) {
            NSLog(@"已经包含matchID:%ld",match.matchId);
            return ;
        }
        
        NSString *sqlStatement = [NSString stringWithFormat:@"INSERT INTO %@ ("
                                  @"%@, "
                                  @"%@, "
                                  @"%@ )"
                                  @"VALUES (? ,? ,?)",
                                  kMatchTable,
                                  kMatchTableID,
                                  kMatchTableHomeName,
                                  kMatchTableAwayName];
        ret = [db executeUpdate:sqlStatement values:@[@(match.matchId),match.homeName,match.awayName] error:&error];
        NSAssert(ret, @"");
        NSAssert(error == nil, error.description);
    }];
    
}

- (void)saveTextLive:(LXTextLive *)textLive {
    NSLog(@"保存开始1matchID:%d:%@",textLive.matchID,[NSThread currentThread]);
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        NSLog(@"保存开始2matchID:%d:%@",textLive.matchID,[NSThread currentThread]);
        BOOL ret = NO;
        NSError *error = nil;
        NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@=? AND %@=?;",kTextLiveTable,kTextLiveTableMatchID,kTextLiveTableTextID];
        FMResultSet *resultSet = [db executeQuery:selectSql values:@[@(textLive.matchID),@(textLive.textID)] error:&error];
        NSAssert(error == nil, @"");
        if (resultSet.next) {
            NSLog(@"已经保存过:matchId:%ld--textID:%ld",textLive.matchID,textLive.textID);
            return ;
        }
        
        NSString *sqlStatement = [NSString stringWithFormat:@"INSERT INTO %@ ("
                                  @"%@, "
                                  @"%@, "
                                  @"%@ )"
                                  @"VALUES (? ,? ,?)",
                                  kTextLiveTable,
                                  kTextLiveTableTextID,
                                  kTextLiveTableMatchID,
                                  kTextLiveTableText];
        
       ret = [db executeUpdate:sqlStatement values:@[@(textLive.textID),@(textLive.matchID),textLive.text] error:&error];
        NSAssert(ret, @"");
        NSAssert(error == nil, error.description);
    }];
    NSLog(@"保存开始3");
}

- (void)deleteMatchByID:(NSInteger)matchID {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
//        NSError *error = nil;
//        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE %@,%@ FROM %@ LEFT JOIN %@ ON %@.%@=%@.%@ WHERE %@.%@=?;",kMatchTable,kTextLiveTable,kMatchTable,kTextLiveTable,kMatchTable,kMatchTableID,kTextLiveTable,kTextLiveTableTextID,kMatchTable,kMatchTableID];
//        BOOL ret = [db executeUpdate:sqlStatement values:@[@(matchID)] error:&error];
//        NSAssert(ret, @"");
//        NSAssert(error == nil, @"");
        
//        NSError *error = nil;
//        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM %@ m,%@ t WHERE m.%@=t.%@ AND m.%@=?;",kMatchTable,kTextLiveTable,kMatchTableID,kTextLiveTableTextID,kMatchTableID];
//        BOOL ret = [db executeUpdate:sqlStatement values:@[@(matchID)] error:&error];
//        NSAssert(ret, @"");
//        NSAssert(error == nil, @"");
        
        NSError *error = nil;
        NSString *sqlStatement = [NSString stringWithFormat:@"DELETE FROM %@,%@ Where %@.%@ = %@.%@;",kTextLiveTable,kMatchTable,kTextLiveTable,kTextLiveTableMatchID,kMatchTable,kMatchTableID];
        BOOL ret = [db executeUpdate:sqlStatement values:nil error:&error];
        NSAssert(ret, @"");
        NSAssert(error == nil, @"");

//        NSError *error = nil;
//        NSString *sqlStatement = [NSString stringWithFormat:@"select * from %@ m,%@ t where m.%@ = t.%@;",kMatchTable,kTextLiveTable,kMatchTableID,kTextLiveTableMatchID];
//        FMResultSet *resultSet = [db executeQuery:sqlStatement values:nil error:&error];
//        NSAssert(error == nil, error.description);
//        while (resultSet.next) {
//            NSInteger matchID = [resultSet intForColumn:@"tbl_match_id"];
//            NSInteger textID = [resultSet intForColumn:@"tbl_textlive_text_id"];
//            NSLog(@"查询结果:matchID:%d==textID:%d",matchID,textID);
//        }
        
    }];
}



@end
