//
//  FMDBManagerConst.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#ifndef FMDBManagerConst_h
#define FMDBManagerConst_h

static NSString *const kTableColumnId               = @"id";

//比赛表
static NSString *const kMatchTable                  = @"tbl_match";

static NSString *const kMatchTableID                = @"tbl_match_id";
static NSString *const kMatchTableHomeName          = @"tbl_match_homename";
static NSString *const kMatchTableAwayName          = @"tbl_match_awayname";

//文字直播表
static NSString *const kTextLiveTable               = @"tbl_textlive";

static NSString *const kTextLiveTableMatchID        = @"tbl_textlive_match_id";
static NSString *const kTextLiveTableTextID         = @"tbl_textlive_text_id";
static NSString *const kTextLiveTableText           = @"tbl_textlive_text";


#endif /* FMDBManagerConst_h */
