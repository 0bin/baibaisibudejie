//
//  BSBasicTableViewController.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    BSBasicTypeAll = 1,
    BSBasicTypeText = 29,
    BSBasicTypeVedio = 41,
    BSBasicTypeVoice = 31,
    BSBasicTypePicture = 10,
    BSBasicTypeVip = 1,
    BSBasicTypeOther = 1,

}BSBasicType;

@interface BSBasicTableViewController : UITableViewController
/**
 *  请求的数据类型
 */
@property (assign, nonatomic) BSBasicType type;
@end
