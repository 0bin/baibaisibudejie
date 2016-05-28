//
//  LBDropDownMenu.m
//  B微博
//
//  Created by LinBin on 15/5/30.
//  Copyright (c) 2015年 LinBin. All rights reserved.
//

#import "LBDropDownMenu.h"
#import "UIView+LBFrameExtension.h"


@interface LBDropDownMenu()

/**
 *  内容视图
 */
@property (weak,nonatomic) UIImageView *contentView;

@end

@implementation LBDropDownMenu


+ (instancetype)menu
{
    return [[self alloc] init];
}

- (UIImageView *)contentView
{
    if (_contentView == nil) {
        
        UIImageView *contentView = [[UIImageView alloc]init];
        [contentView setBackgroundColor:[UIColor redColor]];
        [contentView setImage:[UIImage imageNamed:@"popover_background"]];
        [contentView setUserInteractionEnabled:YES];
        [self addSubview:contentView];
        _contentView = contentView;
        
        }
    return  _contentView;

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setBackgroundColor:[UIColor clearColor]];
        [self contentView];

    }
    return self;
}



- (void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [self setFrame:window.bounds];
    //坐标轴转换 bounds 相对自己，frame 相对父控件
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    //修改frame
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(newFrame) ;
    frame.origin.x = CGRectGetMaxX(newFrame)* 0.3;
    self.frame = frame;
    [window addSubview:self];

    if ([self.LBdelegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.LBdelegate dropDownMenuDidShow:self];
    }
    
}



- (void)dismiss
{
    
    [self removeFromSuperview];
    if ([self.LBdelegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.LBdelegate dropDownMenuDidDismiss:self];
    }
}


- (void)setContent:(UIView *)content
{
   
    _content = content;
    float viewW = content.bounds.size.width ;
    float viewH = content.bounds.size.height ;
    [content setFrame:CGRectMake(10, 15, viewW, viewH)];
    [_contentView setFrame:CGRectMake(0, 0, viewW + 20, viewH + 30)];
    [_contentView addSubview:content];
}


- (void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;
    [self setContent:contentViewController.view];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self dismiss];
}






@end
