//
//  BlockInMethodVC.m
//  GCD
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "BlockInMethodVC.h"
#import "BlockInMethodObj.h"

@interface BlockInMethodVC ()

@end

@implementation BlockInMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
    1,如果不退出控制器，BlockInMethodObj不会dealloc
    2,退出控制器,控制器销毁了，但是BlockInMethodObj不会销毁，原因是dispatch持有了BlockInMethodObj对象
     */
    [[[BlockInMethodObj alloc] init] testWithBlock:^{
        NSLog(@"控制器中执行 block");
    }];
    
}

- (void)dealloc {
    NSLog(@"Block in  method vc dealloc");
}

@end
