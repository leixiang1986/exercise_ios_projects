//
//  ViewController.m
//  DownLoad
//
//  Created by mac on 2018/12/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
///Library/WebServer/Documents
@property (weak, nonatomic) IBOutlet UIProgressView *progress;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/test/corebluetooth.mp4"];
    
    
    
}


- (IBAction)start:(id)sender {
    
    
}

- (IBAction)pause:(id)sender {
    
    
}

- (IBAction)cancel:(id)sender {
    
    
}

@end
