//
//  CustomTabbarController.m
//  AppFrame
//
//  Created by leixiang on 2018/11/23.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "CustomTabbarController.h"
#import <objc/runtime.h>
#import "LXViewConsts.h"
#import "Masonry.h"
#import "LXViewConsts.h"

//#import "ViewControllerA.h"
//#import "ViewControllerB.h"
//#import "ViewControllerC.h"

/** App框架(TabbarVC是自定义的, 继承自BaseViewController)
 主要测试根控制器是UINavigationController，UINavigationController的rootViewController是UITabbarController的情况
 测试控制器的跳转
 测试透明导航栏的情况
 测试滑动返回
 登录，和登出动画
 */
/**
 注意细节:
 self.navigationController.navigationBar.topItem设置的是当前控制器的导航控制器最顶部的UINavigationItem
 self.navigationController.navigationItem(.rightBarButtonItem)此时设置的是当前控制器的导航栏的UINavigationItem
 */

//static CGFloat kTabbarHeight = 49 + 29;



#define kTabbarHeight ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)

@interface CustomTabbarController ()<UITabBarDelegate>
@property (nonatomic, strong, readwrite) UITabBar *tabBar;

@end

@implementation CustomTabbarController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSAssert(NO, @"Please user initWithViewControllers: withTabBarInfos: instead");
    self = [self initWithViewControllers:@[] withTabBarInfos:@[]];
    return self;
}

- (instancetype)initWithNibName:(NSString *_Nullable)nibNameOrNil bundle:(NSBundle *_Nullable)nibBundleOrNil {
    NSAssert(NO, @"Please user initWithViewControllers: withTabBarInfos: instead");
    self = [self initWithViewControllers:@[] withTabBarInfos:@[]];
    return self;
}

- (instancetype)initWithViewControllers:(NSArray *)viewControllers withTabBarInfos:(NSArray *)tabBarInfos {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _selectedIndex = -1;
        _viewControllers = viewControllers;
        _tabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTabbarHeight) withInfos:tabBarInfos];
        _tabBar.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}

- (void)setupUI {
    [self setSelectedIndex:0];
    _tabBar.selectedItem = _tabBar.items.firstObject;
    [self.view addSubview:_tabBar];
    [_tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(kTabbarHeight);
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    NSParameterAssert(selectedIndex < self.viewControllers.count);
    if (_selectedIndex == selectedIndex) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarController:shouldSelectViewController:)]) {
             BOOL should = [self.delegate tabbarController:self shouldSelectViewController:_selectedViewController];
            if (!should) {
                return;
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarController:didSelectViewController:)]) {
            [self.delegate tabbarController:self didSelectViewController:_selectedViewController];
        }
        return;
    }
    _selectedIndex = selectedIndex;
    BaseViewController *selectVC = [self.viewControllers objectAtIndex:_selectedIndex];
    if (_selectedViewController != selectVC) {
        [self setSelectedViewController:selectVC];
    }
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    if (![self.viewControllers containsObject:selectedViewController]) {
        NSLog(@"%@ not in the controllers",selectedViewController);
        return;
    }
    
    if (_selectedViewController == selectedViewController) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
            BOOL should = [self.delegate tabbarController:self shouldSelectViewController:_selectedViewController];
            if (!should) {
                return;
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarController:didSelectViewController:)]) {
            [self.delegate tabbarController:self didSelectViewController:_selectedViewController];
        }
        return;
    }
    
    if (_selectedViewController != nil) {
        //移除之前调用，传入nil
        [_selectedViewController willMoveToParentViewController:nil];
        [_selectedViewController beginAppearanceTransition:NO animated:NO];
        [_selectedViewController.view removeFromSuperview];
        [_selectedViewController endAppearanceTransition];
        [_selectedViewController removeFromParentViewController];
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarController:didUnselectViewController:)]) {
            [self.delegate tabbarController:self didUnselectViewController:_selectedViewController];
        }
    }
    
    _selectedViewController = selectedViewController;
    
    [self addChildViewController:selectedViewController];
    
    if (self.isOnScreen) {
        [self.selectedViewController beginAppearanceTransition:YES animated:NO];
    }
    
    if (self.edgesForExtendedLayout & UIRectEdgeBottom) {
        self.selectedViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.tabBar.bounds.size.height);
    } else {
        self.selectedViewController.view.frame = self.view.bounds;
    }
    [self.view addSubview:self.selectedViewController.view];
    
    if (self.isOnScreen) {
        [self.selectedViewController endAppearanceTransition];
    }
    //添加时调用didMoveToParentViewController:传入父控制器
    [self.selectedViewController didMoveToParentViewController:self];
    
    self.title                                                          = self.selectedViewController.title;
    self.navigationItem.title                                           = self.selectedViewController.title;
    self.navigationController.navigationBar.topItem.titleView           = self.selectedViewController.navigationItem.titleView;
    self.navigationController.navigationBar.topItem.leftBarButtonItem   = self.selectedViewController.navigationItem.leftBarButtonItem;
    self.navigationController.navigationBar.topItem.rightBarButtonItem  = self.selectedViewController.navigationItem.rightBarButtonItem;
    self.navigationController.navigationBar.topItem.leftBarButtonItems  = self.selectedViewController.navigationItem.leftBarButtonItems;
    self.navigationController.navigationBar.topItem.rightBarButtonItems = self.selectedViewController.navigationItem.rightBarButtonItems;
    //外部为category只读属性，内部通过kvc赋值
    [_selectedViewController setValue:self forKey:@"customTabBarController"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabbarController:didSelectViewController:)]) {
        [self.delegate tabbarController:self didSelectViewController:_selectedViewController];
    }
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    [self setSelectedIndex:index];
}

@end

@implementation BaseViewController (CustomTabbarController)

- (CustomTabbarController *)customTabBarController {
    return objc_getAssociatedObject(self, @selector(customTabBarController));
}

- (void)setCustomTabBarController:(CustomTabbarController *)customTabBarController {
    objc_setAssociatedObject(self, @selector(customTabBarController), customTabBarController, OBJC_ASSOCIATION_RETAIN);
}

@end


@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame withInfos:(NSArray *)infos {
    if (self = [super initWithFrame:frame]) {
        _infos = infos;
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:infos.count];
        for (NSDictionary *info in infos) {
            UITabBarItem *item = [[UITabBarItem alloc] init];
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:(UIControlStateSelected)];
            item.image = [[UIImage imageNamed:info[kTabBarDefaultImageKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.selectedImage = [[UIImage imageNamed:info[kTabBarHighlightImageKey]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
            item.title = info[kTabBarTitleKey];
            [items addObject:item];
        }
        
        self.items = [items copy];
    }

    return self;
}



@end
