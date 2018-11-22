//
//  UILabel+LXLocalize.m
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UILabel+LXLocalize.h"
#import <objc/runtime.h>
#import "LanguageHeader.h"

@implementation UILabel (LXLocalize)

- (void)localizedString:(NSString *)key {
    [self setLocalizedStringKey:key];
    [self setText:NSLocalizedString(key, nil)];
}

#pragma mark - Private
- (void)languageChanged {
    [self setText:NSLocalizedString([self localizedStringKey], nil)];
}

- (void)setLocalizedStringKey:(NSString *)key {
    if ([self localizedStringKey] == nil) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged) name:LXLanguageChangedNotification object:nil];
    }
    objc_setAssociatedObject(self, @selector(localizedStringKey), key, OBJC_ASSOCIATION_COPY);
}

- (NSString *)localizedStringKey {
    return objc_getAssociatedObject(self, @selector(localizedStringKey));
}

- (void)setLocalizedAttributeStringKey:(NSString *)key {
    objc_setAssociatedObject(self, @selector(localizedAttributeStringKey), key, OBJC_ASSOCIATION_COPY);
}

- (NSString *)localizedAttributeStringKey {
    return objc_getAssociatedObject(self, @selector(localizedAttributeStringKey));
}

@end
