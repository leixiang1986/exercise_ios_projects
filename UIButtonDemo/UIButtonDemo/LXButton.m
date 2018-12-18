//
//  LXButton.m
//  UIButtonDemo
//
//  Created by mac on 2018/12/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "LXButton.h"

@implementation LXButton

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"发送给了%s toTarget %@",action,target);
    [super sendAction:action to:target forEvent:event];
}
@end
