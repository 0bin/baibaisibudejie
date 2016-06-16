//
//  BBBVerticalLayout.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/16.
//  Copyright © 2016年 LinBin. All rights reserved.
//  垂直流水布局

#import "BBBVerticalLayout.h"

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
    NSInteger 

}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.array;
}

@end
