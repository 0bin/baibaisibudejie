//
//  BBBScrollLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/14.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBScrollLayout.h"

@implementation BBBScrollLayout

- (instancetype)init
{
    if (self = [super init]) {
    
    }
    return  self;
}

/**
 *  cell布局初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    CGFloat margin = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}


/**
 *  所有cell属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *original = [super layoutAttributesForElementsInRect:rect];
    NSArray *array = [[NSArray alloc] initWithArray:original copyItems:YES];
    CGFloat collectionCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in array) {
        CGFloat distance = ABS( attr.center.x - collectionCenterX);
        CGFloat scale = 1 - distance / self.collectionView.frame.size.width * 0.6;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

/**
 *  当显示范围发生改变时，是否刷新布局
    1、调用prepareLayout 2、layoutAttributesForElementsInRect
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  滑动停止时偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minD = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in array) {
        if ( ABS(minD) > ABS(attr.center.x - centerX) ) {
            minD = attr.center.x - centerX;
        }
    }
    proposedContentOffset.x += minD;
    return proposedContentOffset;
}


@end
