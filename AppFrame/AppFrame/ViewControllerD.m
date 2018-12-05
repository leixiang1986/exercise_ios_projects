//
//  ViewControllerD.m
//  AppFrame
//
//  Created by leixiang on 2018/11/27.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewControllerD.h"

@interface ViewControllerD ()

@end

@implementation ViewControllerD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"vcD 从没有导航栏push进入";
    self.view.backgroundColor = [UIColor blueColor];
    
//    NSMutableArray *leftItems = [[NSMutableArray alloc] initWithArray:@[self.navigationItem.backBarButtonItem]];
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:NULL];
//    [leftItems addObject:leftItem];
//    self.navigationItem.leftBarButtonItems = leftItems;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%s",__func__);
    //这里设置才会有滑动返回，导航栏跟随的效果
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
