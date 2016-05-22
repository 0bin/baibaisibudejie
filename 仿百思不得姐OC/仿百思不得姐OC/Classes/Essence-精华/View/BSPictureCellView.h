//
//  BSPictureCellView.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/22.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTextDataModel;

@interface BSPictureCellView : UIView
/**
 *  数据
 */
@property (strong, nonatomic) BSTextDataModel *model;
+ (instancetype)pictureView;



@end
