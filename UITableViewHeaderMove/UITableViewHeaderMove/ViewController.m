//
//  ViewController.m
//  UITableViewHeaderMove
//
//  Created by 雷祥 on 2019/3/26.
//  Copyright © 2019 雷祥. All rights reserved.
//

#import "ViewController.h"
#import "BackView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    BackView *backView = [[BackView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    tempView.backgroundColor = [UIColor whiteColor];
//    tempView.center = CGPointMake(backView.center.x, backView.center.y);
////    [backView addSubview:tempView];
//    backView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:backView];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    NSLog(@"contentSize:%@",NSStringFromCGSize(self.tableView.contentSize));
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 280, kScreenWidth, kScreenHeight - 280) style:(UITableViewStylePlain)];
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        header.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        header.userInteractionEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.backgroundColor = [UIColor clearColor];
    }
    
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    header.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.2];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"测试%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        NSLog(@"contentOffset:%@",NSStringFromCGPoint(scrollView.contentOffset));
        if (self.tableView.contentOffset.y <= 100) {
            _scrollView.contentOffset = CGPointMake(0, self.tableView.contentOffset.y * 0.5);
        } else {
            _scrollView.contentOffset = CGPointMake(0, 50);
        }
    } else if (scrollView == _scrollView){
        
    }
}


@end
