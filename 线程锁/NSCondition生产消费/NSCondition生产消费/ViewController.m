//
//  ViewController.m
//  NSCondition生产消费
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSCondition *condition;
@end

@implementation ViewController
static int testIndex = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _datas = [[NSMutableArray alloc] init];
    _condition = [[NSCondition alloc] init];
    
    //模拟先读取，没有数据，在条件处等待，有数据后，发送信号，接受信号后再消费
    [[[NSThread alloc] initWithTarget:self selector:@selector(read) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(write) object:nil] start];
    
}

- (void)read {
    [_condition lock];
    sleep(1);
    if (_datas.count == 0) {
        [_condition wait];
    }
    id obj = [_datas objectAtIndex:0];
    [_datas removeObjectAtIndex:0];
    [_condition unlock];
    NSLog(@"取出对象:%@",obj);
}

- (void)write {
    sleep(0.5);
    [_condition lock];
    sleep(2);
    [_datas addObject:@(testIndex++)];
    [_condition signal];
    NSLog(@"添加了对象%d",testIndex - 1);
    [_condition unlock];
}


@end
