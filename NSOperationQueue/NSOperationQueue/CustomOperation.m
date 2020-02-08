//
//  CustomOperation.m
//  NSOperationQueue
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomOperation.h"

@interface CustomOperation (){
  BOOL finished;
  BOOL executing;
}
@end

@implementation CustomOperation
- (void)start {
  [NSThread detachNewThreadWithBlock:^{
    //执行的任务。。。
    [NSThread sleepForTimeInterval:1];

    NSLog(@"task==");
//添加监听，外部添加completionBlock监听执行结束
    [self willChangeValueForKey:@"executing"];
    [self willChangeValueForKey:@"finished"];
    finished = YES;
    executing = NO;
    [self didChangeValueForKey:@"finished"];
    [self didChangeValueForKey:@"executing"];
  }];
  NSLog(@"start==");

  [self willChangeValueForKey:@"executing"];
    executing = YES;
    [self didChangeValueForKey:@"executing"];
}

- (BOOL)isFinished {
  return finished;
}

-  (BOOL)isExecuting {
  return executing;
}@end
