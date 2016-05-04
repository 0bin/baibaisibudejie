//
//  BSCategoryModel.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSCategoryModel.h"

@implementation BSCategoryModel

+(instancetype)modelWithDict:(NSDictionary *)dict {

    BSCategoryModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;

}

@end
