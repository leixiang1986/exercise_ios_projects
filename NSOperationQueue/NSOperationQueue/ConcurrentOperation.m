//
//  ConcurrentOperation.m
//  NSOperationQueue
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 admin. All rights reserved.
//

#import "ConcurrentOperation.h"

@interface ConcurrentOperation (){
  BOOL        executing;
  BOOL        finished;
}

@end

@implementation ConcurrentOperation
- (instancetype)initWithName:(NSString *)name {
  self = [self init];
  if (self) {
    self.name = name;
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    executing = NO;
    finished = NO;
  }
  
  return self;
}

- (void)start {
  if ([self isCancelled]) {
    [self willChangeValueForKey:@"isFinished"];
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    return;
  }
  
  [self willChangeValueForKey:@"isExecuting"];
  [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
  executing = YES;
  [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
  if ([self isCancelled]) {
    [self willChangeValueForKey:@"isFinished"];
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    return;
  }
  
  NSLog(@"task----begin");
  [NSThread sleepForTimeInterval:2];
  NSLog(@"task----end:%@",[NSThread currentThread]);
  [self completeOperation];
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting {
  return executing;
}

- (BOOL)isFinished {
  return finished;
}

- (BOOL)isConcurrent {
  return YES;
}

@end
