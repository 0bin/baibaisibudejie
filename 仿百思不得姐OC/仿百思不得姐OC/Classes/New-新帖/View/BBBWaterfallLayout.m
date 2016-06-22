//
//  BBBWaterfallLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/22.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBWaterfallLayout.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width

static const CGFloat BBBColumnMargin = 1;
static const CGFloat BBBRowMargin = 1;
static const UIEdgeInsets BBBEdgeInsets = {1, 1, 1, 1};
static const NSInteger BBBcolumnCount = 3;


@interface BBBWaterfallLayout ()

/**  所有cell属性  */
@property (strong, nonatomic) NSMutableArray *arrayM;
/**  所有列的高度  */
@property (strong, nonatomic) NSMutableArray *allColumnHeight;

- (NSUInteger)columnCount;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;
@end

@implementation BBBWaterfallLayout

/** 设置列数 */
- (NSUInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterfallLayout:)]) {
        return [self.delegate columnCountInWaterfallLayout:self];
    } else {
        return BBBcolumnCount;
    }
}

- (CGFloat)columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterfallLayout:)]) {
        return [self.delegate columnMarginInWaterfallLayout:self];
    } else {
        return BBBColumnMargin;
    }
}

- (CGFloat)rowMargin;
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterfallLayout:)]) {
        return [self.delegate rowMarginInWaterfallLayout:self];
    } else {
        return BBBColumnMargin;
    }
}

- (UIEdgeInsets)edgeInsets;
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterfallLayout:)]) {
        return [self.delegate edgeInsetsInWaterfallLayout:self];
    } else {
        return BBBEdgeInsets;
    }
}

/**  所有列的高度  */
- (NSMutableArray *)allColumnHeight
{
    if (_allColumnHeight == nil) {
        _allColumnHeight = [NSMutableArray array];
    }
    return _allColumnHeight;
}

/**  所有cell属性  */
- (NSMutableArray *)arrayM
{
    if (_arrayM == nil) {
        _arrayM = [NSMutableArray array];
    }
    return _arrayM;
}



- (void)prepareLayout
{
    [super prepareLayout];
    //不清除数组会越来越大
    [self.arrayM removeAllObjects];
    [self.allColumnHeight removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.allColumnHeight addObject:@(BBBEdgeInsets.top)];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.arrayM addObject:attr];
    }
    
}


/**
 *  所有cell的属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return  self.arrayM;
}


/**
 *  每个cell的属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    __block CGFloat minHeight = [self.allColumnHeight[0] doubleValue];;
    __block NSInteger targetColumn = 0;
    [self.allColumnHeight enumerateObjectsUsingBlock:^(NSNumber *columnH, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = columnH.doubleValue;
        if (minHeight > columnHeight) {
            minHeight = columnHeight;
            targetColumn = idx;
        }
    }];
    CGFloat collecitonW = self.collectionView.bounds.size.width;
    CGFloat allMargin = BBBEdgeInsets.left + BBBEdgeInsets.right + (self.columnCount - 1) * BBBColumnMargin;
    CGFloat Width = (collecitonW - allMargin) / self.columnCount;
    CGFloat x = BBBEdgeInsets.left + targetColumn * (BBBColumnMargin + Width);
    CGFloat y = minHeight ;
    if (y != BBBEdgeInsets.top) {
        y += BBBRowMargin;
    }
    
    CGFloat h = [self.delegate waterfallLayout:self heightForItemAtIndexPath:indexPath itemWidth:Width];
    
    attr.frame = CGRectMake(x, y, Width, h);
    
    self.allColumnHeight[targetColumn] = @(CGRectGetMaxY(attr.frame));
    
    return attr;
}

/**
 *  滚动范围
 */
- (CGSize)collectionViewContentSize
{
    __block CGFloat maxHeight = [self.allColumnHeight[0] doubleValue];;
    
    [self.allColumnHeight enumerateObjectsUsingBlock:^(NSNumber *columnH, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = columnH.doubleValue;
        if (maxHeight < columnHeight) {
            maxHeight = columnHeight;
        }
    }];
    return CGSizeMake(0, maxHeight + BBBEdgeInsets.bottom);
}

@end
