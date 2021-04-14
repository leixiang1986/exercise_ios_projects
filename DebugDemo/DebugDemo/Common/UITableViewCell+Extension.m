//
//  UITableViewCell+Extension.m
//  DebugDemo
//
//  Created by leixiang on 2021/4/12.
//

#import "UITableViewCell+Extension.h"

@implementation UITableViewCell (Extension)
+ (NSString *)identifier {
    return [NSString stringWithFormat:@"%@_identifier",NSStringFromClass([self class])];
}
@end
