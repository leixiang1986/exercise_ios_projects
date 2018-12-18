//
//  DownloadManager.m
//  DownLoad
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "DownloadManager.h"

//@interface DownloadTaskDelegate: NSObject
//@property (nonatomic, )
//@end
//
//@im

#define THREADLOCK      dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
#define THREADUNLOCK    dispatch_semaphore_signal(_semaphore);

@interface DownloadManager ()<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableDictionary *tasks;
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation DownloadManager

+ (instancetype)shareManager {
    static DownloadManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DownloadManager alloc] init];
        
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(1);
        _tasks = [[NSMutableDictionary alloc] init];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"lx_download"];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
        
    }
    return self;
}


- (NSURLSessionTask *)downloadWithURL:(NSURL *)url progress:(CGFloat)progress complete:(void(^)(NSString *location))complete {
    THREADLOCK
    NSURLSessionDownloadTask *task = [_session downloadTaskWithURL:url];
    [_tasks setObject:task forKey:@(task.taskIdentifier)];
    [task resume];
    THREADUNLOCK
    return task;
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
    
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    
}


@end
