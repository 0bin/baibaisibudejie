//
//  BBBRoundLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/17.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBRoundLayout.h"

@interface BBBRoundLayout ()
/**
 *  <#Description#>
 */
@property (strong, nonatomic) NSMutableArray *arrayM;

@end

@implementation BBBRoundLayout

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
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat roundCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat roundCenterY = self.collectionView.frame.size.height * 0.5;
    CGFloat radius = 100;
    for (NSInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.size = CGSizeMake(50, 50);
        CGFloat angle = (2 * M_PI / count) * i;
        CGFloat centerX = roundCenterX + radius * sin(angle);
        CGFloat centerY = roundCenterY + radius * cos(angle);
        attr.center = CGPointMake(centerX, centerY);
        [self.arrayM addObject:attr];
    }
    

}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.arrayM;
}

@end
