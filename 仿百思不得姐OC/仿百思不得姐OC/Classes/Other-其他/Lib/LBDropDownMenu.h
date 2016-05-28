//
//  LBDropDownMenu.h
//  B微博
//
//  Created by LinBin on 15/5/30.
//  Copyright (c) 2015年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  设置代理协议
 */
@class LBDropDownMenu;
@protocol DropDownMenuDelegate <NSObject>
@optional
- (void)dropDownMenuDidShow:(LBDropDownMenu *)menu;
- (void)dropDownMenuDidDismiss:(LBDropDownMenu *)menu;
@end


@interface LBDropDownMenu : UIView

@property (weak,nonatomic) id<DropDownMenuDelegate> LBdelegate;

/**
 * 可传 uiview 内容
 */
@property (strong,nonatomic) UIView *content;

/**
 * 可传 UIViewController 内容
 */
@property (strong,nonatomic) UIViewController *contentViewController;

+ (instancetype)menu;

/**
 *  显示方法,并可从来源处显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  取消显示
 */
- (void)dismiss;


@end
