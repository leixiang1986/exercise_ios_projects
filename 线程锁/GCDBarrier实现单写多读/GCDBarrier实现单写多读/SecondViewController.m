//
//  SecondViewController.m
//  GCDBarrier实现单写多读
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SecondViewController.h"
#import <pthread.h>

@interface SecondViewController ()
{
    pthread_rwlock_t lock;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pthread_rwlock_init(&lock, NULL);
 
    
    
    
    
}

- (void)dealloc {
    pthread_rwlock_destroy(&lock);
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
    sleep(0.25);
    pthread_rwlock_rdlock(&lock);
    sleep(0.3);
    NSLog(@"read %@",[NSThread currentThread]);
    pthread_rwlock_unlock(&lock);
}

- (void)write {
    sleep(0.3);
    pthread_rwlock_wrlock(&lock);
    sleep(1);
    NSLog(@"write %@",[NSThread currentThread]);
    pthread_rwlock_unlock(&lock);
}





@end
