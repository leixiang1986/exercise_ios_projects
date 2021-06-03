//
//  ViewController.m
//  UIViewRotation
//
//  Created by mac on 2019/7/4.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGPoint point = CGPointMake(self.testView.frame.origin.x, self.testView.frame.origin.y + self.testView.frame.size.height * 0.5);
    self.testView.layer.anchorPoint = CGPointMake(0, 0.5);
    
    NSLog(@"%@",NSStringFromCGPoint(self.testView.layer.position));
    NSLog(@"%@",NSStringFromCGPoint(point));
    
    self.testView.layer.position = point;
    
    self.testView.layer.transform = CATransform3DMakeRotation(0.5, 0, 0, 1);
}


@end
