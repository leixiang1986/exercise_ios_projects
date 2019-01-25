//
//  AutoSizingCellViewController.m
//  UICollectionViewTest
//
//  Created by 雷祥 on 2019/1/25.
//  Copyright © 2019 雷祥. All rights reserved.
//

#import "AutoSizingCellViewController.h"
#import "AutoSizingCollectionViewCell.h"
#import "Masonry.h"

@interface AutoSizingCellViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AutoSizingCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.estimatedItemSize = CGSizeMake(100, 60);
        flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:flowLayout];
        UINib *nib = [UINib nibWithNibName:@"AutoSizingCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"AutoSizingCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 100; i++) {
            NSMutableString *mutableString = [[NSMutableString alloc] init];
            NSInteger count = arc4random() % 3 + 1;
            for (NSInteger j = 0; j < count; j++) {
                 [mutableString appendFormat:@" %ld-%ld ",(long)count,(long)i];
            }
            [_dataSource addObject:mutableString];
        }
    }
    
    return _dataSource;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AutoSizingCollectionViewCell *cell = (AutoSizingCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AutoSizingCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.dataSource[indexPath.item];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}


@end
