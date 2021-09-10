//
//  SecondViewController.m
//  URLDemo
//
//  Created by LeiXiang on 2021/8/20.
//  Copyright © 2021 mac. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"testNotify" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotify" object:nil];
    NSLog(@"通知结束");
}

- (void)notification:(id)notify {
    NSInteger a = 0;
    for (NSInteger i = 0; i < 10000; i++) {
        a += arc4random() % 3;
    }
    NSLog(@"sadafa:%zi",a);
}

- (void)dealloc {
    NSLog(@"dealloc ==");
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
