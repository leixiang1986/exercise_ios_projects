//
//  AutoSizingCollectionViewCell.m
//  UICollectionViewTest
//
//  Created by 雷祥 on 2019/1/25.
//  Copyright © 2019 雷祥. All rights reserved.
//

#import "AutoSizingCollectionViewCell.h"

#define itemHeight 60
@implementation AutoSizingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes *attributes = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    NSLog(@"item中的内容:%@",self.label.text);
    CGRect rect = [self.label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 1000) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.label.font} context:nil];
    
    if (_sizeBlock) {
        CGSize size = _sizeBlock(rect.size);
        rect.size.width = size.width;
        rect.size.height = size.height;
    } else {
        rect.size.width +=0;
        rect.size.height+=10;
    }
    attributes.frame = rect;
    return attributes;
}



@end
