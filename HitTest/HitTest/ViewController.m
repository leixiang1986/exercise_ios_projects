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
#import "TestBaseView.h"

@interface ViewController ()

@end

/**
 初步总结：(点击红色的viewC)
 
 点击一个view，会从根view开始执行pointInside:withEvent:方法，直到点击view的所有子view。当到达点最上层的点击view时，返回为YES，其所有子view返回都为NO。所以能够确定是点击的view被点击了。这里的例子test1是点击viewC，看打印结果能够印证结论。检测的顺序是从后添加的子view开始检测。
 如果返回为NO，会立即检测hitTest:withEvent:方法，查看是否返回为nil，如果为nil那么该view就不响应事件。
 如果pointInside:withEvent:返回为YES，那么会在pointInside:withEvent:检测完成之后统一检测hitTest:withEvent:是否返回view
 
 注意这里不响应事件是指touchesBegan:withEvent:这些方法不会执行。是否执行tap事件待测试。
 
 特殊测试1：在TestbaseView中做如下判断，点击viewD，响应的依然是viewC
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
     
     UIView *view = [super hitTest:point withEvent:event];
     NSLog(@"%@ %s,返回:%@",self.name,__func__,view);
     if ([self.name isEqualToString:@"viewC"]) {
         return self;
     }
     return view;
 }

 - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
     BOOL isInside = [super pointInside:point withEvent:event];
     NSLog(@"%@ %s,返回:%d",self.name,__func__,isInside);
     if ([self.name isEqualToString:@"viewC"]) {
         return NO;
     }
     return isInside;
 }
 做如上修改，点击到viewD，响应的也是viewC，说明最后起决定性作用的是hitTest:withEvent:方法返回的view，并且不会执行viewD的pointInside:withEvent:和hitTest:withEvent:方法。
 
 最后总结:
 iOS中的事件传递的过程是，从根View开始执行pointInside:withEvent:判断事件是否在当前view上，然后从其子view（后添加的view先执行，这里有原因，因为后添加的在上面显示，优先响应事件的原因所在）上开始执行pointInside:withEvent:方法，直到最后返回为NO或知道其没有子view为止。如果返回为NO，就开始执行hitTest:withEvent:看返回的是否有view，如果有那么第一个view就是执行事件的view，其父控件及祖先空间也会执行hitTest:withEvent:方法，通常返回的是上面一个view的hitTest:withEvent:方法返回的view，但是如果进行了修改，就会是修改后的view执行对应事件，例如做如下修改，点击viewE和viewD都会是viewC进行事件响应：
 - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
     
     UIView *view = [super hitTest:point withEvent:event];
     NSLog(@"%@ %s,返回:%@",self.name,__func__,view);
     if ([self.name isEqualToString:@"viewC"]) {
         return self;
     }
     return view;
 }
 */


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test1];

    

    
}

- (void)test1 {
    TestBaseView *viewA = [[TestBaseView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    viewA.backgroundColor = [UIColor yellowColor];
    viewA.name = @"viewA";
    [self.view addSubview:viewA];
    
    TestBaseView *viewB = [[TestBaseView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    viewB.backgroundColor = [UIColor cyanColor];
    viewB.name = @"viewB";
    [viewA addSubview:viewB];
    
    TestBaseView *viewC = [[TestBaseView alloc] initWithFrame:CGRectMake(150, 0, 150, 150)];
    viewC.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    viewC.name = @"viewC";
    [viewA addSubview:viewC];
    
    TestBaseView*viewD = [[TestBaseView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    viewD.name = @"viewD";
    viewD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [viewC addSubview:viewD];
    
    ///viewE和ViewD一样是viewC的子view，但是viewE在viewD之后添加，并且有交叠，响应的是ViewE。原因是viewE后添加，检查事件时是从后添加的subViews中开始检查的，检查到了(hitTest:withEvent:返回了view)就不在继续检查
    TestBaseView*viewE = [[TestBaseView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    viewE.name = @"viewE";
    viewE.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
    [viewC addSubview:viewE];
}


@end
