//
//  VCBPresentVCViewController.m
//  AppFrame
//
//  Created by mac on 2018/12/5.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "VCBPresentVCViewController.h"

@interface VCBPresentVCViewController ()

@end

@implementation VCBPresentVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
