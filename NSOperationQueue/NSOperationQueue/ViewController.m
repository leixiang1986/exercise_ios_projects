//
//  ViewController.m
//  NSOperationQueue
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *opQueue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _opQueue = [[NSOperationQueue alloc] init];
    
    [self testBlockOpOnly];
    
}

- (void)testBlockOpOnly {
    NSBlockOperation *op = [[NSBlockOperation alloc] init];
    [op addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"1%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"2%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"3%@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"4%@",[NSThread currentThread]);
    }];
    NSLog(@"当前线程:%@",[NSThread currentThread]);
    [_opQueue addOperation:op];
    [_opQueue cancelAllOperations];
}



@end
