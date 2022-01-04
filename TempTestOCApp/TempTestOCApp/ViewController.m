//
//  ViewController.m
//  TempTestOCApp
//
//  Created by LeiXiang on 2021/9/15.
//

#import "ViewController.h"


@interface ViewController ()
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        for (NSInteger i = 0; i < 100; i++) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//                [self create];
//            });
//            [NSThread sleepForTimeInterval:0.1];
//        }
//    });
//
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        for (NSInteger i = 0; i < 100; i++) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//                [self consume];
//            });
//            [NSThread sleepForTimeInterval:0.1];
//        }
//    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       NSLog(@"进入了block");
       [NSThread sleepForTimeInterval:3];
       dispatch_semaphore_signal(_semaphore);
    });
       
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"解锁完成");
}

- (void)create {
    dispatch_barrier_sync(_queue, ^{
        self.count++;
        NSLog(@"写入----:%zi",self.count);
    });
}

- (void)consume {
    dispatch_sync(_queue, ^{
        NSLog(@"只写====:%zi",self.count);
    });
}


@end
