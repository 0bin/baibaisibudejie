//
//  LBTouchTopWindow.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/5.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTouchTopWindow : NSObject
/**
 *  开启点击状态栏 回到scroll最上界面
 */
+ (void)show;

/**
 *  关闭点击状态栏 回到scroll最上界面
 */
+ (void)hidden;

@end
