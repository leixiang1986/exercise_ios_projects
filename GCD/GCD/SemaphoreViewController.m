//
//  SemaphoreViewController.m
//  GCD
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SemaphoreViewController.h"

@interface SemaphoreViewController ()

@end

@implementation SemaphoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)method {
    //信号量同步线程
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    for (int i = 0; i < 20; i++) {
        dispatch_async(queue, ^{
            // 相当于加锁
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [NSThread sleepForTimeInterval:0.5];
            NSLog(@"i = %zd semaphore = %@", i, semaphore);
            [NSThread sleepForTimeInterval:0.5];
            // 相当于解锁
            dispatch_semaphore_signal(semaphore);
        });
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
