//
//  BSCategoryModel.h
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCategoryModel : NSObject

/** id */
@property (nonatomic, assign) NSInteger id;
/** 总数 */
@property (nonatomic, assign) NSInteger count;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/**
 *  <#Description#>
 */
@property (strong, nonatomic) NSMutableArray *arrayContentData;


+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
