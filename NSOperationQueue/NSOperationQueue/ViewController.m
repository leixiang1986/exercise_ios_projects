//
//  ViewController.m
//  NSOperationQueue
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "CustomOperation.h"
#import "CustomOperation1.h"
#import "NonCurrentOperation.h"
#import "ConcurrentOperation.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *opQueue;
@property (nonatomic, strong) CustomOperation *customOperation;
@property (nonatomic, strong) NonCurrentOperation *nonCurrentOperation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _opQueue = [[NSOperationQueue alloc] init];
  _opQueue.maxConcurrentOperationCount = 3;
    
//    [self testBlockOpOnly];
  [self testConcurrentOperation];
}

- (void)testConcurrentOperation {
  for (NSInteger i = 0; i < 12; i++) {
    ConcurrentOperation *operation = [[ConcurrentOperation alloc] initWithName:[NSString stringWithFormat:@"name:%ld",i]];
    __weak typeof(ConcurrentOperation) *weakOp = operation;
    operation.completionBlock = ^{
      NSLog(@"complete :%@",weakOp.name);
    };
    [_opQueue addOperation:operation];
  }
  
}

- (void)testNonConcurrentOperation {
  for (NSInteger i = 0; i < 12; i++) {
    NonCurrentOperation *operation = [[NonCurrentOperation alloc] initWithName:[NSString stringWithFormat:@"name:%ld",i]];
    __weak typeof(NonCurrentOperation) *weakOp = operation;
    operation.completionBlock = ^{
      NSLog(@"complete :%@",weakOp.name);
    };
    [_opQueue addOperation:operation];
  }
}

//test non cuncurrent operation add to OperationQueue
- (void)testNonConcurrentOperation1 {
  for (NSInteger i = 0; i < 10; i++) {
    CustomOperation1 *operation = [[CustomOperation1 alloc] initWithName:[NSString stringWithFormat:@"name:%ld",i]];
    [_opQueue addOperation:operation];
  }
}

- (void)testBlockOpOnly {
    NSBlockOperation *op = [[NSBlockOperation alloc] init];
  NSBlockOperation *op1 = [[NSBlockOperation alloc] init];
  NSLog(@"%ld==%ld",op1.isConcurrent,op1.isAsynchronous);
//  NSInvocationOperation *opertaion = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
//
//  NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
//    [NSThread sleepForTimeInterval:3];
//    NSLog(@"block opertaion:%@",[NSThread currentThread]);
//  }];
                             
//  [opertaion addDependency:block];
//  [block addDependency:op];
    [op addExecutionBlock:^{
//      for (NSInteger i = 0; i < 100000; i++) {
        NSLog(@"1111111111:%@",[NSThread currentThread]);
//      }
        NSLog(@"1%@",[NSThread currentThread]);
    }];
//    [op addExecutionBlock:^{
//        for (NSInteger i = 0; i < 100000; i++) {
//          NSLog(@"222222:%@",[NSThread currentThread]);
//        }
//        NSLog(@"2%@",[NSThread currentThread]);
//    }];
//    [op addExecutionBlock:^{
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"3%@",[NSThread currentThread]);
//    }];
//    [op addExecutionBlock:^{
//        [NSThread sleepForTimeInterval:4];
//        NSLog(@"4%@",[NSThread currentThread]);
//    }];
//    NSLog(@"当前线程:%@",[NSThread currentThread]);
//    [_opQueue addOperation:op];
  [op start];
  
//  [_opQueue addOperation:op1];
//  [_opQueue addOperation:block];
//  [_opQueue addOperation:opertaion];
//    [_opQueue cancelAllOperations];
}

- (void)run {
  NSLog(@"nsinvocation:%@",[NSThread currentThread]);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _customOperation = [[CustomOperation alloc] init];
  _customOperation.completionBlock = ^{
    NSLog(@"complete");
  };
  [_customOperation start];
  
}

@end
