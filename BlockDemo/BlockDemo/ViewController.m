//
//  ViewController.m
//  BlockDemo
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Test__BlockViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

//测试数组通过block块遍历，如何
- (void)test {
    _arr = @[@"1",@"2",@"3",@"4"];
    NSError *error = nil;
    [self findWithError:&error];
}

//数组的block中有autoreleasepool，如果直接设置error的值，block结束后error对象就会被释放
- (id)findWithError:(NSError *__autoreleasing *_Nullable)error {
    __block NSError *tempError = nil;
    [_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"4"]) {
            tempError = [NSError errorWithDomain:@"test" code:-1 userInfo:nil];
        }
    }];
    
    *error = tempError;
    
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //__block在mrc下不对指向的对象进行强引用，arc对对象进行强引用
    Test__BlockViewController *vc = [[Test__BlockViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
//    [vc release];
}


@end
