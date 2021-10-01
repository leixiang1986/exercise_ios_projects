//
//  DecorationCollectionFlowLayout.m
//  UICollectionViewTest
//
//  Created by LeiXiang on 2021/10/1.
//  Copyright © 2021 雷祥. All rights reserved.
//

#import "DecorationCollectionFlowLayout.h"
#import "DecorationCollectionViewDecorationView.h"
#import "Define.h"

#define kDecorationViewKind @"DecorationCollectionViewDecorationView"

@interface DecorationCollectionFlowLayout ()
@property (nonatomic, strong) NSMutableDictionary *decorationViewAttributesCache;
@property (nonatomic, strong) NSMutableDictionary *headerAttributesCache;
@end

@implementation DecorationCollectionFlowLayout

-(instancetype)init {
    self = [super init];
    if (self) {
        [self registerClass:[DecorationCollectionViewDecorationView class] forDecorationViewOfKind:kDecorationViewKind];
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%zi",indexPath.section];
    UICollectionViewLayoutAttributes *attribuites = [self.decorationViewAttributesCache objectForKey:key];
    if (attribuites == nil) {
        attribuites = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationViewKind withIndexPath:indexPath];
        
        attribuites == nil ?: [self.decorationViewAttributesCache setObject:attribuites forKey:key];
        attribuites.zIndex = -1;
    }
    return attribuites;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArr = [super layoutAttributesForElementsInRect:rect];
//    NSLog(@"--------------开始--------------");
    NSMutableArray *mutableAttributesArray = nil;
    
    if (attributesArr.count) {
        mutableAttributesArray = [[NSMutableArray alloc] initWithArray:attributesArr];
    }
    ///decorationView以headerAttributes为基准可能出现header不在react内，但cell在react内的情况，这样就会出现背景突然消失的问题。
    ///通过比较cell的indexPath数组和header的indexPath数组是否一致作为判断
    NSMutableSet *headerIndexPaths = [[NSMutableSet alloc] init];
    NSMutableSet *allIndexPaths = [[NSMutableSet alloc] init];
 
    for (UICollectionViewLayoutAttributes *attributes in attributesArr) {
        if (![allIndexPaths containsObject:attributes.indexPath]) {
            [allIndexPaths addObject:attributes.indexPath];
        }
        if (attributes.representedElementCategory == UICollectionElementCategorySupplementaryView && [attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            
            if (![headerIndexPaths containsObject:attributes.indexPath]) {
                [headerIndexPaths addObject:attributes.indexPath];
            }
            ///缓存headerAttributes
            [self.headerAttributesCache setObject:attributes forKey:[self sectionKeyWithIndexPath:attributes.indexPath]];
            NSLog(@"header:%zi--%zi",attributes.indexPath.section,attributes.indexPath.item);
            ///修改header的位置
            CGRect headerRect = attributes.frame;
            CGFloat headerX = self.sectionInset.left;
            headerRect.origin.x = headerX;
            headerRect.size.width = kScreenWidth - headerX * 2 - self.collectionView.contentInset.left * 2;
            attributes.frame = headerRect;
            
            UICollectionViewLayoutAttributes *decorationAttributes = [self decorationAttributesWithHeaderAttributes:attributes];
            [mutableAttributesArray addObject:decorationAttributes];
        }
        
        ///如果headerIndexPaths的indexPath比allIndexPaths保存的少
        ///说明有header没有展示出来，需要把屏幕外的headerAttributes从缓存中取出，获取对应的decoration
        if (allIndexPaths.count > headerIndexPaths.count) {
             [allIndexPaths minusSet:headerIndexPaths];
            for (NSIndexPath *indexPath in allIndexPaths) {
                NSString *key = [self sectionKeyWithIndexPath:indexPath];
                UICollectionViewLayoutAttributes *headerAttributes = self.headerAttributesCache[key];
                
                UICollectionViewLayoutAttributes *decorationAttributes = [self decorationAttributesWithHeaderAttributes:headerAttributes];
                [mutableAttributesArray addObject:decorationAttributes];
            }
        }
        
    }
    NSLog(@"结束---------");
//    NSLog(@"--------------结束--------------")
    
//    NSLog(@"所有的attributes:%@",mutableAttributesArray);
    
    return [mutableAttributesArray copy];
}

- (UICollectionViewLayoutAttributes *)decorationAttributesWithHeaderAttributes:(UICollectionViewLayoutAttributes *)headerAttrites {
    
    UICollectionViewLayoutAttributes *decorationAttributes = [self layoutAttributesForDecorationViewOfKind:kDecorationViewKind atIndexPath:headerAttrites.indexPath];
    
    ///获取当前section中item的个数
    NSInteger itemCountInSection = [self.collectionView numberOfItemsInSection:headerAttrites.indexPath.section];
    NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:itemCountInSection - 1 inSection:headerAttrites.indexPath.section];
    ///当前section中最后一个item的attributes
    UICollectionViewLayoutAttributes *lastItemAtt = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
    CGFloat adjustX = 20;
    CGFloat y = headerAttrites.frame.origin.y - 10;
    CGFloat x = headerAttrites.frame.origin.x - self.sectionInset.left;
    CGFloat width = kScreenWidth - adjustX * 2;
    CGFloat height = lastItemAtt.frame.origin.y + lastItemAtt.frame.size.height - headerAttrites.frame.origin.y;
    decorationAttributes.frame = CGRectMake(x, y, width, height + 10 * 2);
    return decorationAttributes;
}

#pragma mark - ------------ private --------------
- (NSString *)sectionKeyWithIndexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%zi",indexPath.section];
}
#pragma mark - ------------ getter --------------
- (NSMutableDictionary *)decorationViewAttributesCache {
    if (!_decorationViewAttributesCache) {
        _decorationViewAttributesCache = [[NSMutableDictionary alloc] init];
    }
    return _decorationViewAttributesCache;
}

- (NSMutableDictionary *)headerAttributesCache {
    if (!_headerAttributesCache) {
        _headerAttributesCache = [[NSMutableDictionary alloc] init];
    }
    return _headerAttributesCache;
}
@end
