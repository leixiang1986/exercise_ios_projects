//
//  NonCurrentOperation.m
//  NSOperationQueue
//
//  Created by mac on 2020/2/8.
//  Copyright © 2020 admin. All rights reserved.
//

#import "NonCurrentOperation.h"

@interface NonCurrentOperation ()

@end

@implementation NonCurrentOperation
- (instancetype)initWithName:(NSString *)name {
  if (self = [super init]) {
    self.name = name;
  }
  return self;
}

- (void)main {
  if ([self isCancelled]) {
    return;
  }
//  NSInteger second = arc4random() % 4 + 1;
  [NSThread sleepForTimeInterval:2];
  NSLog(@"delay:%ld--%@:%@",2,self.name,[NSThread currentThread]);
}

@end
