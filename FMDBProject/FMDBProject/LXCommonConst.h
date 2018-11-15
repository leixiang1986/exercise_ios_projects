//
//  LXCommonConst.h
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef LXCommonConst_h
#define LXCommonConst_h


extern inline NSString *getDocumentPath()
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#endif /* LXCommonConst_h */
