//
//  ViewController.m
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import "ViewController.h"
#import "ToDeallocViewController.h"
#import "ManagerA.h"
#import "UITableViewCell+Extension.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titles;
@end
/**
 在dealloc中执行代码应注意，如果classA的dealloc中调用classB的方法-(void)test:(classA)a,传入了classA的实例。如果test:方法是在异步线程执行的，并且异步线程中包含了classA的实例(classA正在销毁)，那么异步线程执行时获取到的classA实例已经销毁了，就会造成崩溃。这就是腾讯视频集成时，单例B中用到单例A，销毁单例B，在单例B的dealloc中，执行单例A移除监听的方法将单例B传入，单例A的移除方法应该是在异步线程执行的并且包含了单例B的实例，这样在执行移除方法的异步处理部分就获取不到单例B的实例了，所以崩溃(Recorded stack frame) 。
 这个例子是模拟这种场景,关键点在于ManagerA中的- (void)removeListener:(id)object方法使用了异步处理。同步是没有问题的。
 
 */
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ToDeallocViewController *vc = [[ToDeallocViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getter and setter
- (NSArray *)titles {
    return @[@"dealloc 中执行异步方法，异步方法中包含了即将dealloc的对象(self)"];
}
@end
