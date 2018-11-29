//
//  ViewController.m
//  NSNotificationExcercise
//
//  Created by leixiang on 2018/11/29.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "NotificationObj.h"

//发送指定指定对象的通知
static NSString *const kSendSpecifiedObjNotification = @"sendSpecifiedObjNotification";
//接收指定对象的通知
static NSString *const kReceiveSpecifiedObjNotification = @"ReceiveSpecifiedObjNotification";
@interface ViewController ()
@property (nonatomic, strong) NotificationObj *obj1;
@property (nonatomic, strong) NotificationObj *obj2;
@end
/**
 Discussion
 
 If your app targets iOS 9.0 and later or macOS 10.11 and later, you don't need to unregister an observer in its dealloc method. Otherwise, you should call removeObserver:name:object: before observer or any object passed to this method is deallocated.
 
 1,不移除通知，对象监听了通知，发送通知后不会再崩溃，说明通知中心现在保存的是weak属性(iOS9不需要移除通知了)
 2,发送和接受都为nil，可以接收到通知
   发送和接收都为指定对象，可以接收到通知
   发送为nil，接收为指定对象，接收不到通知
   发送为指定对象，接收为nil，可以接收到通知
 */


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"vc";
    _obj1 = [[NotificationObj alloc] init];
    _obj2 = [[NotificationObj alloc] init];
    _obj1.name = @"obj1";
    _obj2.name = @"obj2";
    //发送指定，接收为nil，可以接受到通知
    [[NSNotificationCenter defaultCenter] addObserverForName:kSendSpecifiedObjNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"send:%@",note.object);
    }];
    
    //1,接收指定，发送为nil时，接收不到通知
    //2,接收指定，发送也指定为同一个对象可以接受到通知
    [[NSNotificationCenter defaultCenter] addObserverForName:kReceiveSpecifiedObjNotification object:_obj2 queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"receive:%@",note.object);
    }];
    
    
}

- (IBAction)buttonClick:(id)sender {
    //点击进入SecondVC后,退回发送通知
    //之前没有移除通知会崩溃，说明对象添加到通知中心,通知中心持有对象的变量是assign的指针，不是strong或者weak的引用。
    //现在不移除，发送通知不会崩溃
    [[NSNotificationCenter defaultCenter] postNotificationName:kADeallocedObjAddNotificationName object:nil];
}


- (IBAction)sendSpecifiedNofify:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendSpecifiedObjNotification object:_obj1];
}

- (IBAction)receiveSpecifiedNotify:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kReceiveSpecifiedObjNotification object:nil];
}

@end
