//
//  LXCommonUtils.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LXCommonUtils.h"

@implementation LXCommonUtils
+ (BOOL)createDirectorysAtPath:(NSString *)path {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:path]) {
        NSError *error = nil;
        
        if (![manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            return NO;
        }
    }
    
    return YES;
}
@end
