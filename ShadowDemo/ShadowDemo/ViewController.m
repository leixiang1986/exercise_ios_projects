//
//  ViewController.m
//  ShadowDemo
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    view1.layer.cornerRadius = 50;
    view1.layer.shadowColor = [UIColor blackColor].CGColor;
    view1.layer.shadowOffset = CGSizeMake(5, 5);
    view1.layer.shadowOpacity = 0.8;
    
    //单独圆角
    //需要解决的两个问题：
    //1,设置圆角，通过shapeLayer作为mask，可以设置圆角,但在此基础上设置view的圆角是无效的
    //2,添加圆角，在底部再通过一个shapeLayer添加阴影，达到效果
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(180, 60, 200, 100)];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    CAShapeLayer *maskLayer2 = [CAShapeLayer layer];
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
    maskLayer2.path = maskPath2.CGPath;
    maskLayer2.backgroundColor = [UIColor yellowColor].CGColor;
    
//    [self.view.layer insertSublayer:shapeLayer2 atIndex:0];
    //view2设置了mask后，就无法设置阴影了，阴影会被切掉
    //要给view2设置阴影就要另外在底部添加一个有阴影的layer
    view2.layer.mask = maskLayer2;  //设置左上左下的圆角
//    view2.layer.shadowRadius = 10;
//    view2.layer.shadowOpacity = 0.8;
//    view2.layer.shadowOffset = CGSizeMake(0, 10);
//    view2.layer.shadowColor = [UIColor grayColor].CGColor;
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRoundedRect:view2.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(50, 50)];
    
    CAShapeLayer *shadowlayer2 = [CAShapeLayer layer];
    shadowlayer2.path = shadowPath2.CGPath;
    shadowlayer2.shadowRadius = 10;
    shadowlayer2.shadowOpacity = 0.8;
    shadowlayer2.shadowOffset = CGSizeMake(-10, 0);
    shadowlayer2.shadowColor = [UIColor grayColor].CGColor;
    
    [self.view.layer insertSublayer:shadowlayer2 atIndex:0];
    
    
    
}


@end
