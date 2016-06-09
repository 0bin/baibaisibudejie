//
//  BSConst.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 页面类型
 */
typedef enum {
    BSBasicTypeAll = 1,
    BSBasicTypeText = 29,
    BSBasicTypeVedio = 41,
    BSBasicTypeVoice = 31,
    BSBasicTypePicture = 10,
    BSBasicTypeRanking = 9,
    BSBasicTypeOther = 13096,
} BSBasicType;


/**
 *  tabbar选中通知
 */
UIKIT_EXTERN NSString * const BBBTabBarDidSelectedNotification;

UIKIT_EXTERN NSInteger const childVCCount;
UIKIT_EXTERN CGFloat const TextCell;
UIKIT_EXTERN CGFloat const bottomH;