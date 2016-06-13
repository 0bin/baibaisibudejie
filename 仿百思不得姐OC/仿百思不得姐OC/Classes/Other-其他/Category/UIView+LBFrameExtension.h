//  直接.X .Y .W .H
//  UIView+LBFrameExtension.h
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LBFrameExtension)


@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 *  从xib加载控件
 */
+ (instancetype)initWithFromXib;


/**
 *  当前在屏幕显示
 */
- (BOOL)isShowingOnKeyWindow;


@end
