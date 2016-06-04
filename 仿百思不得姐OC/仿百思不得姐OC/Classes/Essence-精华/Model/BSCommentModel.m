//
//  BSCommentModel.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/31.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSCommentModel.h"
#import "BSUserModel.h"

@implementation BSCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}
@end
