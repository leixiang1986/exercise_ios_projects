//
//  ViewController.m
//  TextKitDemo
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSAttributedString *attriString;
    NSDictionary *attrs = @{NSForegroundColorAttributeName: [UIColor redColor],
                            NSTextEffectAttributeName: NSTextEffectLetterpressStyle
                            };
    attriString = [[NSAttributedString alloc] initWithString:@"testhah" attributes:attrs];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 300, 50)];
    lable.attributedText = attriString;
    lable.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:lable];

}



@end
