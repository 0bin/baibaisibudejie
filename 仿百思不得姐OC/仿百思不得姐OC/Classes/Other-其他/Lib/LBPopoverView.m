//
//  LBPopoverView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBPopoverView.h"
#import "BSScanQRCodeViewController.h"

@interface LBPopoverView ()

/**
 *  背景图片视图
 */
@property (weak, nonatomic) UIImageView *contentImageView;

@end

@implementation LBPopoverView

+ (instancetype)popoverView {
    LBPopoverView *popover = [[self alloc] init];
    return popover;

}

- (UIImageView *)contentImageView {
    
    if (_contentImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background_right"]];
        [imageView setUserInteractionEnabled:YES];
        [self addSubview:imageView];
        _contentImageView = imageView;
    }
    return _contentImageView;

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:YES];
    }
    return self;

}

- (void)showPopoverViewFrom:(UIView *)from {
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    [self setFrame:window.frame];
    [window addSubview:self];
    NSInteger count = 3;
    CGFloat const margin = 8;
    CGFloat const buttonH = 44;
    CGFloat const buttonW = 100;
    CGFloat const imageW = buttonW;
    CGFloat const imageH = count * buttonH + margin;
    NSArray *buttonText = @[@"扫一扫",@"雷达",@"地图"];
    NSArray *buttonImageName = @[@"Profile_AddV_authen",@"Profile_AddV_authen",@"Profile_AddV_authen"];
    //坐标轴转换 bounds 相对自己，frame 相对父控件
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    CGFloat const imageX = CGRectGetMaxX(newFrame) - imageW + from.bounds.size.width ;
    CGFloat const imageY = CGRectGetMaxY(newFrame) ;
    [self.contentImageView setFrame:CGRectMake(imageX, imageY, imageW, imageH)];
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc] init];
        CGFloat const buttonX = 0;
        CGFloat const buttonY = buttonH * i + margin;
        button.tag = i;
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button setTitle:buttonText[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:buttonImageName[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.contentImageView addSubview:button];
        
    }

}

- (void)popverButtonClick:(UIButton *)button {
    NSLog(@"-----------------------");
    if (button.tag == 0) {
        BSScanQRCodeViewController *QRCode = [[BSScanQRCodeViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:QRCode animated:YES completion:^{
            
            
        }];
         NSLog(@"-----------------------");
    } else if (button.tag == 1) {
    
    } else {
    
    }
    [self dismiss];

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
}

- (void)dismiss {

    [self removeFromSuperview];

}
@end
