//
//  ViewController.m
//  FMDBProject
//
//  Created by leixiang on 2018/11/14.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "FMDBManager+LXMatchTest.h"
#import "LXMatch.h"
#import "LXTextLive.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [FMDBManager shareManager];
    _index = 1;
    NSLog(@"开始保存数据");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 0; i < 10; i++) {
            LXMatch *match = [[LXMatch alloc] init];
            match.matchId = i;
            match.homeName = [NSString stringWithFormat:@"homename%ld",i];
            match.awayName = [NSString stringWithFormat:@"awayname%ld",i];

            [[FMDBManager shareManager] saveMatch:match];
            for (NSInteger j = 0; j < 10; j++) {
                LXTextLive *textLive = [[LXTextLive alloc] init];
                textLive.matchID = i;
                textLive.textID = j + i * 10;
                textLive.text = [NSString stringWithFormat:@"matchId = %ld,textID = %ld",i,j];

                [[FMDBManager shareManager] saveTextLive:textLive];
            }
        }
    });

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSInteger i = 10; i < 20; i++) {
            LXMatch *match = [[LXMatch alloc] init];
            match.matchId = i;
            match.homeName = [NSString stringWithFormat:@"2homename%ld",i];
            match.awayName = [NSString stringWithFormat:@"2awayname%ld",i];

            [[FMDBManager shareManager] saveMatch:match];
            for (NSInteger j = 10; j < 20; j++) {
                LXTextLive *textLive = [[LXTextLive alloc] init];
                textLive.matchID = i;
                textLive.textID = j + i * 10;
                textLive.text = [NSString stringWithFormat:@"2matchId = %ld,2textID = %ld",i,j];

                [[FMDBManager shareManager] saveTextLive:textLive];
            }
        }
    });

    NSLog(@"保存数据完成");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[FMDBManager shareManager] deleteMatchByID:_index++];
}



@end
