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
+ (instancetype)shareManager
{
    static DTLanguageTools  *instance = nil;
    static dispatch_once_t  onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[DTLanguageTools alloc] init];
    });
     
    return instance;
}

- (void)setLanguageType:(DTLanguageType)type
{
    _languageType = type;
    // 更换bundle
    [NSBundle setLanguageBundle:[self bundleNameWithType:type]];
    // 替换顺序
    [self setAppleLangagesWithType:type];
}

#pragma mark - private
- (NSString *)languageWithType:(DTLanguageType)type
{
    NSString *language = nil;
    
    switch (type) {
        case DTLanguageType_en:
            language = @"en-CN";
            break;
            
        case DTLanguageType_zh_Hans:
            language = @"zh-Hans-CN";
            break;
            
        default:
            language = @"zh-Hans-CN";
            break;
    }
    
    return language;
}

- (NSString *)bundleNameWithType:(DTLanguageType)type
{
    NSString *bundleName = nil;
    
    switch (type) {
        case DTLanguageType_en:
            bundleName = @"en";
            break;
            
        case DTLanguageType_zh_Hans:
            bundleName = @"zh-Hans";
            break;
            
        default:
            bundleName = @"zh-Hans";
            break;
    }
    
    return bundleName;
}

- (void)setAppleLangagesWithType:(DTLanguageType)type
{
    NSArray         *oldLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSMutableArray  *currentLanguages = [[NSMutableArray alloc] initWithArray:oldLanguages];
    NSString        *language = [self languageWithType:type];
    NSInteger       index = [currentLanguages indexOfObject:language];
    
    if (index != NSNotFound) {
        if (index != 0) {
            [currentLanguages removeObject:language];
            [currentLanguages insertObject:language atIndex:index];
        }
    } else {
        [currentLanguages insertObject:language atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[currentLanguages copy] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
