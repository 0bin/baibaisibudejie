//
//  UIImageView+BBBImageViewCategory.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/7.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (BBBImageViewCategory)
/**
 *  设置圆形头像
 *
 *  @param url 头像地址
 */
- (void)setEllipseIconWithUrl:(NSString *)url;


/**
 *  设置原始头像
 *
 *  @param url 头像地址
 */
- (void)setIconWithUrl:(NSString *)url;

@end
