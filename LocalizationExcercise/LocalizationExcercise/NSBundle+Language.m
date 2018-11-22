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
    if (bundle != nil) {
        return [bundle localizedStringForKey:key
                                       value:value
                                       table:tableName];
    } else {
        return [super localizedStringForKey:key
                                      value:value
                                      table:tableName];
    }
}

@end

@implementation NSBundle (Language)
+ (void)setLanguageBundle:(NSString *)bundleName
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [DTLanguageBundel class]);
    });
    //当bundleName为nil时，返回的是MainBundle
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"lproj"]];
    objc_setAssociatedObject([NSBundle mainBundle], &kLanguageBundleKey, bundle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
