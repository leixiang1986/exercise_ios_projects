//
//  ViewController.m
//  SystemShareAndReceiveDoc
//
//  Created by leixiang on 2021/5/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self share];
}

- (void)share {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (path.length == 0) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *items = @[data,url];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    vc.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
        NSLog(@"分享后:%@--%@",returnedItems,activityError);
    };
    [self presentViewController:vc animated:YES completion:nil];
}

@end
