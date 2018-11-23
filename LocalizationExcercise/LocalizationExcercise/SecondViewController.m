//
//  SecondViewController.m
//  LocalizationExcercise
//
//  Created by leixiang on 2018/11/22.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "SecondViewController.h"
#import "NSBundle+Language.h"
#import <objc/message.h>
#import "CustomView.h"
#import "DTLanguageTools.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"是否重新开始");
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试语言切换的页面跳转";
    [self showResult];
}

- (void)showResult {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    label.text = NSLocalizedString(@"Test", nil);
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
}

- (IBAction)changeLanguage:(id)sender {
    if ([DTLanguageTools shareManager].languageType == DTLanguageType_en) {
        [[DTLanguageTools shareManager] setLanguageType:(DTLanguageType_zh_Hans)];
    } else {
        [[DTLanguageTools shareManager] setLanguageType:(DTLanguageType_en)];
    }
    
    [self reloadViewControllers];
}

//跳转回到设置页面
- (void)reloadViewControllers {
   UITabBarController *tabbarVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    tabbarVC.selectedIndex = 2;
   UIViewController *secondVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
    UINavigationController *settingVC = [tabbarVC.viewControllers objectAtIndex:2];
    NSMutableArray *viewControllers = [settingVC.viewControllers mutableCopy];
    [viewControllers addObject:secondVC];
    settingVC.viewControllers = viewControllers;
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabbarVC;
}


@end
