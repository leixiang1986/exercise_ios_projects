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
    
    _data = [NSMutableArray arrayWithCapacity:10];
    for (NSInteger i = 0; i < 10; i++) {
        [_data addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    _queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    
    
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self read];
        });
    }
    
    for (NSInteger i = 0; i < 1000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self write];
        });
    }
}

- (void)read {
    dispatch_async(_queue, ^{
        sleep(1);
        NSLog(@"读取数据");
    });
}

- (void)write {
    dispatch_barrier_async(_queue, ^{
        sleep(1);
        NSLog(@"写入数据");
    });
}



@end
