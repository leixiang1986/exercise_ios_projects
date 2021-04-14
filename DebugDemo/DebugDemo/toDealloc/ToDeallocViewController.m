//
//  ToDeallocViewController.m
//  DebugDemo
//
//  Created by leixiang on 2021/4/9.
//

#import "ToDeallocViewController.h"
#import "ManagerB.h"
#import "ManagerA.h"

@interface ToDeallocViewController ()

@end

@implementation ToDeallocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [ManagerB shareInstance];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[ManagerA shareInstance] removeListener:[ManagerB shareInstance]];
}

- (void)dealloc {
    [[ManagerB shareInstance] destroyInstance];
    NSLog(@"TODealloc dealloc");
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
