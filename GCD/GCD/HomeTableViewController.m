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
    
}

- (NSArray *)titleList {
    if (!_titleList) {
        _titleList = @[@"1-方法中的block是否循环-是否可以重复回调",
                      @"2-资源中两个线程分别持有对方需要的锁造成死锁"];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleList[indexPath.row];
 
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        
    }
    
}

#pragma mark - create





@end
