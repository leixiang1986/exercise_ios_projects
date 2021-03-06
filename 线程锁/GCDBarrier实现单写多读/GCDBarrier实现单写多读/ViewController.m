//
//  ViewController.m
//  GCDBarrier实现单写多读
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self read];
        });
    }
    
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self write];
        });
    }

}


- (void)read {
    dispatch_async(_queue, ^{
        sleep(0.3);
        NSLog(@"读取数据:%@",[NSThread currentThread]);
    });
    sleep(0.2);
}

- (void)write {
    sleep(0.3);
    dispatch_barrier_async(_queue, ^{
        sleep(0.5);
        NSLog(@"写入数据:%@",[NSThread currentThread]);
    });
}



@end
