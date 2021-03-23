//
//  UIColor+Extension.m
//  AppFrame
//
//  Created by leixiang on 2021/3/23.
//  Copyright © 2021 admin. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor *)colorWithHexString:(NSString *)color{
    return [self backColorValue:color aValue:1.0f];
}
+(UIColor *)colorWithHexString:(NSString *)color alphaValue:(CGFloat)aValue{
    return [self backColorValue:color aValue:aValue];
}

#pragma mark 通过字符串(hex)返回的颜色值
+(UIColor *)backColorValue:(NSString *)color aValue:(CGFloat)aValue{
    NSString *cString=[[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length]<6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString=[cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString=[cString substringFromIndex:1];
    if ([cString length]!=6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location=0;
    range.length=2;
    
    // R G B 颜色
    NSString *rString=[cString substringWithRange:range];
    range.location=2;
    NSString *gString=[cString substringWithRange:range];
    range.location=4;
    NSString *bString=[cString substringWithRange:range];
    
    // 搜索数值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:aValue];
}
@end
