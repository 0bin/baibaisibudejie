//
//  BSMeDataModel.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/10.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSMeDataModel.h"

@implementation BSMeDataModel

+ (instancetype)modelWihtDict:(NSDictionary *)dict {

    BSMeDataModel *model = [[self alloc] init];
    model.icon = dict[@"icon"];
    model.name = dict[@"name"];
    model.url = dict[@"url"];
    return  model;
    

}

@end
