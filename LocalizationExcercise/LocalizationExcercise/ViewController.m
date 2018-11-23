//
//  ViewController.m
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "NSBundle+Language.h"
#import "SecondViewController.h"
#import "DTLanguageTools.h"
#import <objc/message.h>
#import "CustomView.h"
#import "UILabel+LXLocalize.h"
/**
 实现过程:
 一，国际化功能实现
 1，在Project的设置中添加要国际化的语言
 2，新建Localizable和InfoPlist Strings文件，选中文件后，选择右侧的Localize...，然后勾选需要国际话的语言,在对应语言中选择对应的
 二，DTLanguageTool实现语言切换
 三，xib国际化，自动添加后续添加的内容
 项目目录中导入AutoGenStrings.py文件，在Build Phases中添加执行文件的语句Run script中添加:
 #!/bin/bash
 python ${SRCROOT}/${TARGET_NAME}/RunScript/AutoGenStrings.py ${SRCROOT}/${TARGET_NAME}
 
 四，国际化的页面切换(解决微信页面跳转的动画卡顿)
 出现这个卡顿的原因是微信在切换语言后，重新初始化了页面，在初始化tabbarVC的时候，切换了tabbarIndex,
 然后再进行跳转，这样如果不延时处理，那么切换TabbarIndex会出现失败的情况。
 参照网上的例子通过设置tabbarVC的语言Controller的ViewControllers数组达到直接无动画跳转的效果。具体过程很简单,主要是思想:
 先取出切换语言tabbarVC对应下的NavigationVC，取出ViewControllers，然后初始化并添加需要push的控制器，到ViewControllers，设置回NavigationVC的ViewControllers。这样就实现了直接跳转:
 PBSettingViewController *vc = [[PBSettingViewController alloc] init];
 NSMutableArray *vcs = rootVC.viewControllers.mutableCopy;
 [weakSelf switchToTabAtIndex:1];
 [vcs addObject:vc];
 rootVC.viewControllers = vcs;
 
 */

@interface ViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
//    self.label.text = NSLocalizedString(@"viewController.test", nil);
    [self reloadLabel];
    
   

}
- (IBAction)switchChiese:(id)sender {
//     [[NSUserDefaults standardUserDefaults] setObject:@[@"zh-Hans-CN"] forKey:@"AppleLanguages"];
//    [NSBundle setLanguageBundle:@"zh-Hans"];
    [[DTLanguageTools shareManager] setLanguageType:(DTLanguageType_zh_Hans)];
    [self reloadLabel];
    
}

- (IBAction)switchToEnglish:(id)sender {
    [[DTLanguageTools shareManager] setLanguageType:(DTLanguageType_en)];
    [self reloadLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSLog(@"%@",languages);
}

- (IBAction)restore:(id)sender {
    [[DTLanguageTools shareManager] resetSystemLanguage];
    [self reloadLabel];
}

- (IBAction)next:(id)sender {
//    SecondViewController *second = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:second animated:YES];
}

- (void)reloadLabel {
    [_label removeFromSuperview];
    _label = nil;
    [self.view addSubview:self.label];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
        _label.text = NSLocalizedString(@"Test", nil);
    }
    return _label;
}

@end
