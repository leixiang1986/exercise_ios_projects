//
//  CustomOperation1.m
//  NSOperationQueue
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 admin. All rights reserved.
//

#import "CustomOperation1.h"

@interface CustomOperation1 ()
{
  BOOL finished;
  BOOL executing;
}
@end

@implementation CustomOperation1
- (instancetype)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    self.name = name;
  }
  return self;
}
//add to operationqueue,will create thread for operation
- (void)main {
  if ([self isCancelled]) {
    return;
  }
  [self willChangeValueForKey:@"executing"];
  executing = YES;
  [self didChangeValueForKey:@"executing"];

  [NSThread sleepForTimeInterval:2];
  if ([self isCancelled]) {
    return;
  }
  //add to operationqueue,will create thread for operation
  NSLog(@"%@:%@",self.name,[NSThread currentThread]);
  [self willChangeValueForKey:@"executing"];
  [self willChangeValueForKey:@"finished"];
  finished = YES;
  executing = NO;
  [self didChangeValueForKey:@"finished"];
  [self didChangeValueForKey:@"executing"];

}

- (BOOL)isFinished {
  return finished;
}

- (BOOL)isConcurrent {
  return YES;
}

- (BOOL)isAsynchronous {
  return YES;
}

@end
