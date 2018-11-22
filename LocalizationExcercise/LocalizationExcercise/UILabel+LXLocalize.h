//
//  UILabel+LXLocalize.h
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define L(key) NSLocalizedString(key, nil)
@interface UILabel (LXLocalize)

- (void)localizaedString:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
