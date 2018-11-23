//
//  ViewController.m
//  RuntimeExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import <objc/runtime.h>
#import "CategoryObj+Test1.h"
#import "CategoryObj+Test2.h"
#import "CategoryObj+Exchange1.h"
#import "CategoryObj+Exchange2.h"
#import "SubCategoryObj.h"

/**
 runtime的应用:
 1，数据库中创建table时，用表名和创建方法字符串构造一个key:value字典，通过循环的方式创建表，用RuntimeInvoker的invoke实现;
 2，方法交换的细节：方法实现的IMP指针是通过Method结构体获取到的,而Method结构体又是通过类和方法的SEL获取到的。
 类中获取IMP
 IMP classResumeIMP = method_getImplementation(class_getInstanceMethod(currentClass, @selector(resume)));
 方法交换有两种实现:
 a:方法替换,先给类添加方法，添加成功就替换原来的方法
 BOOL didAddMethod = class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
 if (didAddMethod) {
    class_replaceMethod(class,swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
 } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
 }
 b:方法交换,直接交换两个方法的实现
 method_exchangeImplementations(originalMethod, swizzledMethod);
 出现的问题:
 方案a，虽然是更
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testDealloc];
//    [self testCategoryMethod];
//    [self changeInstanceClass];
//    [self callUnreconglizeMechod];
}

//替换实例的类
- (void)changeInstanceClass {
    object_setClass(self.view, [CustomView class]);
    NSLog(@"%@",self.class);
}

//解决实例和类没有的方法(类中复写实现)
- (void)callUnreconglizeMechod {
    [self.view performSelector:@selector(enene)];
    [CustomView performSelector:@selector(hehe)];
}


- (void)testLoadAndInitialize {
    //不用调用super的initialize方法，会自动调用
    //initialize 在使用时才会调用,只会调用一次
    //load的类和分类在加载时就会调用一次,只会调用一次(如果子类调用了父类的initialize，那么父类的initialize会调用两次)
    [[SubCategoryObj alloc] init];
    [[CategoryObj alloc] init];
}

//测试子类，父类，分类(父类的分类)中都有相同的方法，子类实例调用哪个方法
- (void)testCategoryMethod {
#warning 此处的现象有点令人费解 为什么父类是否实现方法对子类的分类的表现会有差别,并且和父类子类的初始化先后也有关系，如果先初始化子类那么父类有实现test方法，那么就分别执行；如果先初始化父类，那么父类就掉哟过分类方法，子类调用自己的方法
    //情况1:先初始化子类
//    //如果CategoryObj中定义了test方法，那么子类和父类分别调用自己的方法
//    //如果父类CategoryObj中没有定义test方法，那么子类和父类都会调用分类的方法
//    SubCategoryObj *subobj = [[SubCategoryObj alloc] init];
//    CategoryObj *obj = [[CategoryObj alloc] init];
//    [subobj test];
//    [obj test];
#warning 和子类的初始化先后相关 (所以分类不要复写原生类的方法)
    //情况2:先初始化父类
    //如果CategoryObj中定义了test方法，并且先于子类初始化,那么子类调用自己的方法,父类调用分类方法
    //如果父类CategoryObj中没有定义test方法，那么子类和父类都会调用分类的方法
    CategoryObj *obj = [[CategoryObj alloc] init];
    SubCategoryObj *subobj = [[SubCategoryObj alloc] init];
    [subobj test];
    [obj test];
}

//测试多个分类交换dealloc方法的情况
- (void)testDealloc {
    CategoryObj *obj = [[CategoryObj alloc] init];
    [obj test];
}

@end
