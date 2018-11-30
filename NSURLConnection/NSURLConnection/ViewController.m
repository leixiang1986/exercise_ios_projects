//
//  ViewController.m
//  NSURLConnection
//
//  Created by leixiang on 2018/11/28.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDelegate>
@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) NSURLConnection *connection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun:) object:nil];
    [_thread start];
    
}

- (void)threadRun:(id)sender {
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] run];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self request];
}

- (void)request {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1543388796118&di=aa54f6d05284810aef14bdcdabf7df26&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180727%2F3287aca44cb347a59d9ca6adc248c3d3.jpeg"]];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self.connection start];
//    });
    [self performSelector:@selector(start:) onThread:_thread withObject:_connection waitUntilDone:NO];
}

- (void)start:(NSURLConnection *)connection {
    [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.connection start];
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

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"%s_%@",__func__,[NSThread currentThread]);
}


@end
