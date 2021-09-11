//
//  ViewController.m
//  URLDemo
//
//  Created by mac on 2018/12/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

//From AFN
NSString * AFPercentEscapedStringFromString(NSString *string) {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/AFNetworking/AFNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}


@interface ViewController ()<NSURLConnectionDataDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableString *internalName;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/asdfj?abc=123&def=456#12"];
    NSLog(@"%@---%@---%@",url.absoluteString,url.query,url.fragment);
    _internalName = [[NSMutableString alloc] initWithString:@"123"];
    self.name = _internalName;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify) name:@"testNotify" object:nil];
    
    ///发送的线程和接收的线程相同
    for (NSInteger i = 0; i < 10; i++) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i + 1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotify" object:nil];
        });
    }
    
    
//    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
//    NSLog(@"111:%@",[NSThread currentThread]);
//    dispatch_async(queue, ^{
//        NSLog(@"222:%@",[NSThread currentThread]);
//        dispatch_sync(queue, ^{
//            NSLog(@"333:%@",[NSThread currentThread]);
//        });
//        NSLog(@"444:%@",[NSThread currentThread]);
//    });
//    NSLog(@"555:%@",[NSThread currentThread]);
    
}

- (void)setName:(NSMutableString *)name {
    _name = [name copy];
}

- (void)notify {
    
    NSLog(@"-----%@",[NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static int i = 0;
    if (i % 2 == 0) {
        SecondViewController *vc = [[SecondViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotify" object:nil];
    }
    i++;
    
//    self.name = self.internalName;
//    [self.internalName appendString:@"456"];
//    NSLog(@"%@---%@",self.internalName,self.name);
    
}


//URL编码
//通过stringByAddingPercentEncodingWithAllowedCharacters进行编码，可以使包含#等特殊字符的url可以使用
- (void)test {
//    NSString *urlString = @"http://www.baidu.com?image#/小刘.png";
////    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSString *urlString = @"http://127.0.0.1/test/#first.txt";
//
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"host:%@--scheme:%@---%@",url.host,url.scheme,url.path);
//
    
    
   
    
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"111:%@",[NSThread currentThread]);

    dispatch_async(queue, ^{
        NSLog(@"2222:%@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"333:%@",[NSThread currentThread]);
        });
        NSLog(@"4444:%@",[NSThread currentThread]);
    });
    
    NSLog(@"5555:%@",[NSThread currentThread]);
    
//    NSString *tempUrlString = [urlString copy];
//    urlString = AFPercentEscapedStringFromString(urlString);
//
//    NSLog(@"进行编码过后:%@",urlString);
//    urlString = [urlString stringByRemovingPercentEncoding];
//    NSLog(@"进行解码过后:%@",urlString);

    //用编码方式可以请求到数据，如果不编码就请求不到
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
////    urlString = AFPercentEscapedStringFromString(urlString);
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"%s:%@",__func__,response);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"%s",__func__);
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%s",__func__);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%s",__func__);
}



@end
