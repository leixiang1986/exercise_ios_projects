//
//  UIColor+Extension.h
//  AppFrame
//
//  Created by leixiang on 2021/3/23.
//  Copyright © 2021 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
+(UIColor *)colorWithHexString:(NSString *)color;
+(UIColor *)colorWithHexString:(NSString *)color alphaValue:(CGFloat)aValue;
@end

NS_ASSUME_NONNULL_END
