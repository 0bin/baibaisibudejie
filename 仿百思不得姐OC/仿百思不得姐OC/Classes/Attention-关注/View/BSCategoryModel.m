//
//  BSCategoryModel.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSCategoryModel.h"

@implementation BSCategoryModel



- (NSMutableArray *)allUserData
{
    if (!_allUserData) {
        _allUserData = [NSMutableArray array];
    }
    return _allUserData;
}

@end
