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

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;

}
@end
