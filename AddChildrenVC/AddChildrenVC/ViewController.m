//
//  ViewController.m
//  AddChildrenVC
//
//  Created by LeiXiang on 2021/9/10.
//

#import "ViewController.h"
#import "FirstTableViewController.h"
#import "SecondTableViewController.h"

@interface ViewController ()
@property (nonatomic, strong) FirstTableViewController *firstVC;
@property (nonatomic, strong) SecondTableViewController *secondVC;
@property (nonatomic, strong) UIViewController *curChildVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"第一个",@"第二个"]];
    [seg addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    self.navigationItem.titleView = seg;
    _firstVC = [[FirstTableViewController alloc] init];
    _secondVC = [[SecondTableViewController alloc] init];
    [self displayContentController:_firstVC show:YES];
    [self displayContentController:_secondVC show:NO];
    self.curChildVC = _firstVC;
}

- (BOOL) shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

///当前显示的控制器在父类将要显示时，调用子控制器的将要显示
-(void) viewWillAppear:(BOOL)animated {
    [self.curChildVC beginAppearanceTransition: YES animated: animated];
}
 
-(void)viewDidAppear:(BOOL)animated {
    [self.curChildVC endAppearanceTransition];
}
 
-(void)viewWillDisappear:(BOOL)animated {

    [self.curChildVC beginAppearanceTransition: NO animated: animated];
}
 
-(void) viewDidDisappear:(BOOL)animated {
    [self.curChildVC endAppearanceTransition];
}

///手动控制时也要处理下生命周期
- (void)segmentClick:(id)sender {
    UISegmentedControl *seg = sender;
    UIViewController *old = self.curChildVC;
    UIViewController *appearVC = nil;
    [old beginAppearanceTransition:NO animated:YES];
    
    if (seg.selectedSegmentIndex == 0) {
        appearVC = self.firstVC;
        [appearVC beginAppearanceTransition:YES animated:YES];
        _firstVC.view.hidden = NO;
        _secondVC.view.hidden = YES;
        _curChildVC = _firstVC;
    } else {
        appearVC = self.secondVC;
        [appearVC beginAppearanceTransition:YES animated:YES];
        _firstVC.view.hidden = YES;
        _secondVC.view.hidden = NO;
        _curChildVC = _secondVC;
    }
    [old endAppearanceTransition];
    [appearVC endAppearanceTransition];
}

- (void) displayContentController: (UIViewController*) content show:(BOOL)show{
    content.view.hidden = !show;
   [self addChildViewController:content];
    content.view.frame = self.view.bounds;
   [self.view addSubview:content.view];
   [content didMoveToParentViewController:self];
}


@end
