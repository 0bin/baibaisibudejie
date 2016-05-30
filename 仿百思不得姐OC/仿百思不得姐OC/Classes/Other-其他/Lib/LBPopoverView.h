//
//  LBPopoverView.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBPopoverView : UIView

/**
 *  创建popover
 */
+ (instancetype)popoverView;

/**
 *  显示popover
 *
 *  @param from            传点击的view
 *  @param count           传button数量
 *  @param buttonText      button文字
 *  @param buttonImageName button图片
 */
- (void)showPopoverViewFrom:(UIView *)from;

@end
