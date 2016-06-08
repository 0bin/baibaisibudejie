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

- (BOOL)canBecomeFocused
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return YES;
}
@end
