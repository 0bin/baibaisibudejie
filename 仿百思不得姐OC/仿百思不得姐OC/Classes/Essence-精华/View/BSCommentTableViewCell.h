//
//  BSCommentTableViewCell.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/3.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSCommentModel;
@interface BSCommentTableViewCell : UITableViewCell


/**
 *  data
 */
@property (strong, nonatomic) BSCommentModel *model;
@end
