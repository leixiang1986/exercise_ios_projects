//
//  DTLanguageTools.m
//  powercontrol
//
//  Created by leixiang on 2018/6/14.
//  Copyright © 2018年 datangtiancheng. All rights reserved.
//

#import "DTLanguageTools.h"
#import "NSBundle+Language.h"

/** 实现过程
 *   1，在bundle中设置语言时，替换NSUserDefault中的语言数组，替换为第一个是用户选择的语言。
 *   2，将MainBundle替换为子类，在子类中复写国际化实现的方法:
 *   - (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
 *   3，如果要恢复系统语言，将NSUserDefault中的语言数组设置为nil。
 *   注意：原本替换了NSUserDefault中的语言数组，就会显示第一个语言的内容，但是只能重启后才能生效，这是因为没有重启，获取的数据还是从之前Bundle中获取的。为了在当前的状态都能实现，那么就要在设置语言的时候切换对应的bundle。
 */

#define kDTLanguageToolsCurrentType @"DTLanguageToolsCurrentType"

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

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _languageType = [[NSUserDefaults standardUserDefaults] integerForKey:kDTLanguageToolsCurrentType];
    }
    
    return self;
}

- (void)resetSystemLanguage
{
    _languageType = DTLanguageType_system;
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AppleLanguages"];
    [NSBundle setLanguageBundle:nil];
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSLog(@"恢复后的语言:%@", languages);
}

- (void)setLanguageType:(DTLanguageType)type
{
    _languageType = type;
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kDTLanguageToolsCurrentType];
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
            break;
    }
    
    return bundleName;
}

- (void)setAppleLangagesWithType:(DTLanguageType)type
{
    NSArray         *oldLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSMutableArray  *currentLanguages = [[NSMutableArray alloc] initWithArray:oldLanguages];
    NSString        *language = [self languageWithType:type];
    
    if (language.length) {
        NSInteger index = [currentLanguages indexOfObject:language];
        
        if (index != NSNotFound) {
            if (index != 0) {
                [currentLanguages removeObject:language];
                [currentLanguages insertObject:language atIndex:0];
            }
        } else {
            [currentLanguages insertObject:language atIndex:0];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[currentLanguages copy] forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
