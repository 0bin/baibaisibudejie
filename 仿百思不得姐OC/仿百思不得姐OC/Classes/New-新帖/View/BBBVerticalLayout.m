//
//  BBBVerticalLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/16.
//  Copyright © 2016年 LinBin. All rights reserved.
//  垂直流水布局

#import "BBBVerticalLayout.h"
#import "UIView+LBFrameExtension.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface BBBVerticalLayout ()

/**
 *  布局属性数组
 */
@property (strong, nonatomic) NSMutableArray *array;

@end

@implementation BBBVerticalLayout

- (NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGFloat width = kScreenW * 0.5;
        CGFloat height = width;
        CGFloat heightS = height * 0.5;
        
        if (i == 0) {
            CGFloat x = 0;
            CGFloat y = 0;
            attr.frame = CGRectMake(x, y, width, height);
        } else if (i == 1) {
            CGFloat x = kScreenW - width;
            CGFloat y = 0;
            attr.frame = CGRectMake(x, y, width, heightS);
        } else if (i == 2) {
            CGFloat x = kScreenW - width;
            CGFloat y = heightS;
            attr.frame = CGRectMake(x, y, width, heightS);
        } else if (i == 3) {
            CGFloat x = 0;
            CGFloat y = height;
            attr.frame = CGRectMake(x, y, width, heightS);
        } else if (i == 4) {
            CGFloat x = 0;
            CGFloat y = height + heightS;
            attr.frame = CGRectMake(x, y, width, heightS);
        } else if (i == 5) {
            CGFloat x = width;
            CGFloat y = height;
            attr.frame = CGRectMake(x, y, width, height);
        } else {
            
        }

        [self.array addObject:attr];
    }

}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.array;
}

- (CGSize)collectionViewContentSize
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat height = (count + 3 - 1) / 3 * self.collectionView.frame.size.width * 0.5;
    return CGSizeMake(0, height);
}

@end
