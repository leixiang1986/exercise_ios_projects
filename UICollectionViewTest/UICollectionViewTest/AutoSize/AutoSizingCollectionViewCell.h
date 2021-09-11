//
//  AutoSizingCollectionViewCell.h
//  UICollectionViewTest
//
//  Created by 雷祥 on 2019/1/25.
//  Copyright © 2019 雷祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoSizingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, copy) CGSize(^sizeBlock)(CGSize size);
@end

NS_ASSUME_NONNULL_END
