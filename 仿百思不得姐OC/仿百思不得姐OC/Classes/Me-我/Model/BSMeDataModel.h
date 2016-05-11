//
//  BSMeDataModel.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/10.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSMeDataModel : NSObject
@property (copy,nonatomic) NSString *icon;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *url;

+(instancetype)modelWihtDict:(NSDictionary *)dict;
@end
