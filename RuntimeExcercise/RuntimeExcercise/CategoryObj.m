//
//  CategoryObj.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CategoryObj.h"

@implementation CategoryObj

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)load {
    NSLog(@"CategoryObj 中load的打印");
}

+ (void)initialize {
    NSLog(@"CategoryObj 中initialize的打印");
}

- (void)test {
    NSLog(@"CategoryObj 中的test方法");
}

@end
