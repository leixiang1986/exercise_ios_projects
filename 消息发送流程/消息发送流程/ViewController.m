//
//  ViewController.m
//  消息发送流程
//
//  Created by LeiXiang on 2021/9/11.
//

#import "ViewController.h"
#import "NSObject+extension.h"

/**
 方法封装在NSObject+extension中
 
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark - 测试

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelectorWithString:@"testStrSelector:" parameters:@{@"name":@"安德鲁"} callback:nil];
    
}

- (void)testStrSelector:(NSDictionary *)para {
    NSLog(@"执行了testStrSelector:%@",para);
}



@end
