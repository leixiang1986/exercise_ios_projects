//
//  Test__BlockViewController.m
//  BlockDemo
//
//  Created by mac on 2018/12/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "Test__BlockViewController.h"
#import "Person.h"


@interface Test__BlockViewController ()
@property (nonatomic, strong) Person *person;
@end

@implementation Test__BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _person = [[Person alloc] init];
    __block typeof(self)blockSelf = self;
    _person.block = ^{
        [blockSelf test];
    };
    
    
    
}

- (void)test {
    NSLog(@"执行了test");
}

- (void)dealloc {
    NSLog(@"%s",__func__);
//    [_person release];
//    [super dealloc];
}


@end
