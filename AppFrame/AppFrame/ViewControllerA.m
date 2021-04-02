//
//  ViewControllerA.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewControllerA.h"
#import "ViewControllerD.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"VC_A";
    self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    [self test];
    
}

///测试入口
- (void)test {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self asyncMethodWithType:3 complete:^{
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    [self asyncMethodWithType:2 complete:^{
        dispatch_semaphore_signal(semaphore);
    }];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"最后执行");
}


/// 异步方法
/// @param type 类型
/// @param complete 完成回调
- (void)asyncMethodWithType:(NSInteger)type complete:(void(^)(void))complete {
    NSLog(@"执行类型%ld",type);
    if (type <= 0) {
        complete();
        return ;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ///模拟之行任务
        [NSThread sleepForTimeInterval:(arc4random() % 3 + 1) / 10];
        !complete ?: complete();
    });
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s",__func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s",__func__);
}

- (void)buttonClick:(id)sender {
    ViewControllerD *vcD = [[ViewControllerD alloc] init];
    vcD.title = @"从有导航栏的vc进入";
    [self.navigationController pushViewController:vcD animated:YES];
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
