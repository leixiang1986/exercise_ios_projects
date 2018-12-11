//
//  HomeTableViewController.m
//  GCD
//
//  Created by leixiang on 2018/11/21.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "HomeTableViewController.h"
#import "BlockInMethodVC.h"

@interface HomeTableViewController ()
@property (nonatomic, strong) NSArray *titleList;
@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
}

- (NSArray *)titleList {
    if (!_titleList) {
        _titleList = @[@"1-方法中的block是否循环-是否可以重复回调",
                      @"2-资源中两个线程分别持有对方需要的锁造成死锁",
                       @"3-信号量同步数据"];
    }
    return _titleList;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.titleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = self.titleList[indexPath.row];
    cell.textLabel.numberOfLines = 0;
 
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self pushToBlockInMethodVC];
    } else if (indexPath.row == 1) {
        
    }
    
}

#pragma mark - create

- (void)pushToBlockInMethodVC {
    BlockInMethodVC *vc = [[BlockInMethodVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
