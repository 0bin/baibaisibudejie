//
//  BBBLabel.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/8.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBLabel.h"

@implementation BBBLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBBBLabel];
    }
    return  self;
}

- (void)awakeFromNib
{
    [self setBBBLabel];

}

- (void)setBBBLabel
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BBBLabelClick)]];

}

- (void)BBBLabelClick
{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];

}

/**
 *  设置控件能成为第一响应者			
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

/**
 *  弹出选项，yes显示全部
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:) ) {
        return YES;
    }
    return NO;
}

- (void)copy:(UIMenuController *)menu
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
   
    
}
- (void)cut:(UIMenuController *)menu
{
    [self copy:menu];
    self.text = nil;

}
- (void)paste:(UIMenuController *)menu
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.text = pasteboard.string ;
    
}
@end
