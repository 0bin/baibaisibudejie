//
//  BSWaterfallLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSWaterfallLayout.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
static const CGFloat BBBColumnMargin = 5;
static const CGFloat BBBRowMargin = 5;
static const UIEdgeInsets BBBEdgeInsets = {5, 5, 5, 5};
static const NSInteger BBBcolumnCount = 3;

@interface BSWaterfallLayout ()

/**  所有cell属性  */
@property (strong, nonatomic) NSMutableArray *arrayM;
/**  所有列的高度  */
@property (strong, nonatomic) NSMutableArray *allColumnHeight;
@end

@implementation BSWaterfallLayout

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
    for (NSInteger i = 0; i < BBBcolumnCount; i++) {
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
 *  每个cell的属性
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
    CGFloat allMargin = BBBEdgeInsets.left + BBBEdgeInsets.right + (BBBcolumnCount - 1) * BBBColumnMargin;
    CGFloat Width = (collecitonW - allMargin) / BBBcolumnCount;
    CGFloat x = BBBEdgeInsets.left + targetColumn * (BBBColumnMargin + Width);
    CGFloat y = minHeight ;
    if (y != BBBEdgeInsets.top) {
        y += BBBRowMargin;
    }
    
    CGFloat h = 50 + arc4random_uniform(100);
    attr.frame = CGRectMake(x, y, Width, h);
    
    self.allColumnHeight[targetColumn] = @( CGRectGetMaxY(attr.frame) );

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
