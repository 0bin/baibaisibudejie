//
//  BSTitleTableViewCell.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/4.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCategoryModel.h"

@interface BSTitleTableViewCell : UITableViewCell
@property (strong, nonatomic) BSCategoryModel *CategoryModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
