//
//  NSBundle+Language.m
//  powercontrol
//
//  Created by fuzzy@fdore.com on 2018/6/22.
//  Copyright © 2018年 datangtiancheng. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/message.h>

static const NSString *kLanguageBundleKey = @"kLanguageBundleKey";

@interface DTLanguageBundel : NSBundle

@end

@implementation DTLanguageBundel
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle *bundle = objc_getAssociatedObject(self, &kLanguageBundleKey);
    
    return bundle ?[bundle localizedStringForKey:key value:value table:tableName] :[super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (Language)
+ (void)setLanguageBundle:(NSString *)language
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [DTLanguageBundel class]);
    });
    id test = [NSBundle mainBundle];
    NSLog(@"测试bundule类型:%@", test);
    objc_setAssociatedObject([NSBundle mainBundle], &kLanguageBundleKey, language ?[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
