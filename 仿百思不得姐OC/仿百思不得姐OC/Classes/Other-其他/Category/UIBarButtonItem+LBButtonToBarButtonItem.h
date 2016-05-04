//
//  UIBarButtonItem+LBButtonToBarButtonItem.h
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LBButtonToBarButtonItem)

/**
 *  将button封装成UIBarButtonItem
 *
 *  @param image          图片名
 *  @param highlightImage 高亮图片
 *  @param target         self
 *  @param action         SEL
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *) itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
//+ (UIBarButtonItem *) itemWithTitle:(NSString *)title image:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
