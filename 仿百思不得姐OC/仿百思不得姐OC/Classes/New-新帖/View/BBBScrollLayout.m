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
    NSArray *attr = [super layoutAttributesForElementsInRect:rect];
    
    
    return attr;

}

@end
