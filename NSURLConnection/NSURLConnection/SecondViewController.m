//
//  SecondViewController.m
//  NSURLConnection
//
//  Created by leixiang on 2018/11/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self request];
}

/**
 直接设置delegateQueue就可以不用开启runloop,在dispatch的临时多线程中开始runloop是没有用的
 */
- (void)request {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"当前线程:%@",[NSThread currentThread]);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543388796118&di=aa54f6d05284810aef14bdcdabf7df26&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180727%2F3287aca44cb347a59d9ca6adc248c3d3.jpeg"]];
        NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        //直接设置delegate的代理操作队列就可以了
        if (!_queue) {
            _queue = [[NSOperationQueue alloc] init];
        }
        [connect setDelegateQueue:_queue];
//开启临时线程的runloop没有用
//        [[NSRunLoop currentRunLoop] run];
        [connect start];
    });
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
}
- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    return NO;
}
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    [[challenge sender] continueWithoutCredentialForAuthenticationChallenge:challenge];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
}

@end
