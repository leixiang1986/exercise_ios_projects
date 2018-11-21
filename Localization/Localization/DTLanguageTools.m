//
//  DTLanguageTools.m
//  powercontrol
//
//  Created by leixiang on 2018/6/14.
//  Copyright © 2018年 datangtiancheng. All rights reserved.
//

#import "DTLanguageTools.h"
#import "NSBundle+Language.h"


@implementation DTLanguageTools
+ (instancetype)shareManager {
    static DTLanguageTools *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DTLanguageTools alloc] init];
    });
    
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)setLanguageType:(DTLanguageType)type {
    _languageType = type;
    NSArray *arr = nil;
    if (_languageType == DTLanguageType_en) {
        arr = @[@"en-CN",@"zh-Hans-CN"];
        [NSBundle setLanguage:@"en"];
    }
    else if (_languageType == DTLanguageType_zh_Hans) {
        arr = @[@"zh-Hans-CN",@"en-CN"];
        [NSBundle setLanguage:@"zh-Hans"];
    }
    if (arr) {
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
