//
//  Manager.m
//  UIButtonDemo
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Manager.h"

@implementation Manager
+ (instancetype)shareInstance {
    static Manager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Manager alloc] init];
    });
    
    return instance;
}


@end
