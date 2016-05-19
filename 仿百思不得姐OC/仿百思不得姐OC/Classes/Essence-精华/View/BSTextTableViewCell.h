//
//  BSTextTableViewCell.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/19.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTextDataModel;
@interface BSTextTableViewCell : UITableViewCell

/**
 *  模型数据
 */
@property (strong, nonatomic)  BSTextDataModel *textData;

+ (instancetype)cell;

@end
