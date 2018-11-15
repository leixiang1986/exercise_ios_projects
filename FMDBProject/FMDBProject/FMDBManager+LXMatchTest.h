//
//  FMDBManager+LXMatchTest.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "FMDBManager.h"
#import "LXMatch.h"
#import "LXTextLive.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMDBManager (LXMatchTest)

- (void)saveMatch:(LXMatch *)match;
- (void)saveTextLive:(LXTextLive *)textLive;

- (void)deleteMatchByID:(NSInteger)matchID;

@end

NS_ASSUME_NONNULL_END
