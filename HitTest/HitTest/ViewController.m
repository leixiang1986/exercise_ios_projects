//
//  ViewController.m
//  HitTest
//
//  Created by leixiang on 2018/11/20.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "TestViewA.h"
#import "TestViewB.h"
#import "TestViewC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test1];
    //注意添加顺序和点击A，Bview的不同效果
    //可以看出，检查从点击view的同一级后添加的view开始检查pointInside:withEvent:
    //如果返回YES，那么检查该view的子view，一次类推，然后检查最后一个返回YES的子view的hitTest:withEvent:
//    [self test2];
    
}

- (void)test1 {
    TestViewA *viewA = [[TestViewA alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    viewA.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewA];
    
    TestViewB *viewB = [[TestViewB alloc] initWithFrame:CGRectMake(100, 200, 200, 150)];
    viewB.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:viewB];
    
    TestViewC *viewC = [[TestViewC alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    viewC.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [viewA addSubview:viewC];
}

- (void)test2 {
    TestViewA *viewA = [[TestViewA alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    viewA.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewA];
    
    TestViewB *viewB = [[TestViewB alloc] initWithFrame:CGRectMake(100, 200, 200, 150)];
    viewB.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:viewB];
    
    TestViewC *viewC = [[TestViewC alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    viewC.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    [viewB addSubview:viewC];
}


@end
