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
#import "TestObject+BindTest.h"
#import "SubTestObject.h"

/**
 runtime的应用:
 1，数据库中创建table时，用表名和创建方法字符串构造一个key:value字典，通过循环的方式创建表，用RuntimeInvoker的invoke实现;
 2，方法交换的细节：方法实现的IMP指针是通过Method结构体获取到的,而Method结构体又是通过类和方法的SEL获取到的。
 类中获取IMP
 IMP classResumeIMP = method_getImplementation(class_getInstanceMethod(currentClass, @selector(resume)));
 方法交换有两种实现:
 a:方法替换,先给类添加方法，添加成功就替换原来的方法
  如果一个类没有实现dealloc方法，那么就会出现添加dealloc方法就会成功，然后才是替换。如果实现了dealloc方法，那么添加方法就会返回为NO
 BOOL didAddMethod = class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),method_getTypeEncoding(swizzledMethod));
 if (didAddMethod) {
    class_replaceMethod(class,swizzledSelector,method_getImplementation(originalMethod),method_getTypeEncoding(originalMethod));
 } else {
    method_exchangeImplementations(originalMethod, swizzledMethod);
 }
 b:方法交换,直接交换两个方法的实现
 method_exchangeImplementations(originalMethod, swizzledMethod);
 
 3,object_开头的函数参数是具体的对象相关的函数(一般参数是具体的对象,比如要获取具体的对象的值等)，objc_开头的函数是泛指的对象相关的函数(一般参数是对象所属的类，通过对类进行操作，改变实例对象的属性，如objc_getAssociatedObject())
 
 */

@interface ViewController ()
@property (nonatomic, strong) TestObject *testObj;
@property (nonatomic, strong) SubTestObject *subTestObj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //多个分类交换dealloc，调用自身，可以实现全部都得到调用
//    [self testDealloc];
//    [self testCategoryMethod];
//    [self changeInstanceClass];
//    [self callUnreconglizeMechod];
//    [self testExchangeSubClassTest];
//    [self testIvar];
    //绑定的属性是否有kvo
//    [self testAssociateKVO];
//    [self testOverwriteSetter];
    //测试绑定属性kvc,可以
    [self testAssociateKVC];
    
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

//测试多个分类交换dealloc方法的情况(交换方法在NSObject的扩展中)
//结论：多个分类交换dealloc方法，如果在交换的方法中调用了自身，那么都会得到执行，并且如果自身实现了dealloc，那么自身dealloc也会得到执行
- (void)testDealloc {
    CategoryObj *obj = [[CategoryObj alloc] init];
    [obj test];
}

//测试子类交换test方法，分为子类重写和不重写进行交换(交换方法在NSObject的扩展中)
- (void)testExchangeSubClassTest {
    SubCategoryObj *obj = [[SubCategoryObj alloc] init];
    [obj exchange];
}

//测试获取变量的类型和值
- (void)testIvar {
    unsigned int count;
    name = @"测试";
    _age = 13;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i= 0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        const char *ivarType = ivar_getTypeEncoding(ivar);
//        id value = [self valueForKey:[NSString stringWithUTF8String:ivarName]];
        //如果是通过runtime来做,那么需要判断是否是对象类型，对象类型就用object_getIvar(self, ivar)获取；
        //C语言类型就通过对象的指针偏移来做,具体可参照:FLEXRuntimeUtility
        //其中有一个CASE的宏定义思想，方法进入只会匹配一种情况
        id value = nil;
        if (ivarType[0] == @encode(id)[0] || ivarType[0] == @encode(Class)[0]) {
            value = object_getIvar(self, ivar);
        } else {
            ptrdiff_t offset = ivar_getOffset(ivar);
            void *pointer = (__bridge void *)self + offset;
            value = [self valueForPrimitivePointer:pointer objCType:ivarType];
        }
        NSLog(@"得到的值:%@",value);
        NSLog(@"Ivar(%d): %@==type:%@", i, [NSString stringWithUTF8String:ivarName],[NSString stringWithUTF8String:ivarType]);
    }
    free(ivarList);
    
}

//通过对象的ivar获取C类型的数据
- (NSValue *)valueForPrimitivePointer:(void *)pointer objCType:(const char *)type
{
    // CASE macro inspired by https://www.mikeash.com/pyblog/friday-qa-2013-02-08-lets-build-key-value-coding.html
#define CASE(ctype, selectorpart) \
if(strcmp(type, @encode(ctype)) == 0) { \
return [NSNumber numberWith ## selectorpart: *(ctype *)pointer]; \
}
    
    CASE(BOOL, Bool);
    CASE(unsigned char, UnsignedChar);
    CASE(short, Short);
    CASE(unsigned short, UnsignedShort);
    CASE(int, Int);
    CASE(unsigned int, UnsignedInt);
    CASE(long, Long);
    CASE(unsigned long, UnsignedLong);
    CASE(long long, LongLong);
    CASE(unsigned long long, UnsignedLongLong);
    CASE(float, Float);
    CASE(double, Double);
    
#undef CASE
    
    NSValue *value = nil;
    @try {
        value = [NSValue valueWithBytes:pointer objCType:type];
    } @catch (NSException *exception) {
        // Certain type encodings are not supported by valueWithBytes:objCType:. Just fail silently if an exception is thrown.
    }
    
    return value;
}

//测试结果，不加willChangeValueForKey和didChangeValueForKey会执行kvo，添加了反而会执行两次
//MJRefresh中Chategory的block添加了willChangeValueForKey和didChangeValueForKey，但测试绑定添加block，似乎没有这个问题，也是可以监听到kvo的
- (void)testAssociateKVO {
    _testObj = [[TestObject alloc] init];
    _testObj.name = @"测试名字";
    [_testObj addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:NULL];
    [_testObj addObserver:self forKeyPath:@"block" options:(NSKeyValueObservingOptionNew) context:NULL];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.testObj.name = @"修改了名字";
        self.testObj.block = ^{
            NSLog(@"block");
        };
        [self testAssociateKVO];
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"] || [keyPath isEqualToString:@"block"]) {
        NSLog(@"接收到了testobj的KVO --name:%@",change);
    } else if ([keyPath isEqualToString:@"age"]) {
        NSLog(@"SubTestObj的kvo触发了 %@",change);
    }
}

//测试子类复写了setter方法的kvo
//结论:当为普通属性变量时，复写setter方法，会触发kvo
- (void)testOverwriteSetter {
    _subTestObj = [[SubTestObject alloc] init];
    _subTestObj.age = 10;
    [_subTestObj addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew) context:NULL];
    void(^block)(void) = ^{
        NSLog(@"这是一个block");
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _subTestObj.age = 10;
    });
}

//绑定属性可以kvc
- (void)testAssociateKVC {
    TestObject *test = [[TestObject alloc] init];
    [test setValue:@"leixiang" forKey:@"name"];
    NSLog(@"%@",test.name);
}


@end
