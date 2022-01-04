//
//  ViewController.m
//  zhsz
//
//  Created by LeiXiang on 2022/1/4.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseUrl = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Base_url"];
    NSLog(@"base url:%@",baseUrl);
    
}


@end
