//
//  LBSquareButton.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/14.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBSquareButton.h"
#import "UIView+LBFrameExtension.h"

@implementation LBSquareButton


- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    
    [self setup];
    
}

- (void)layoutSubviews {
    
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.4;
    self.imageView.height = self.width * 0.4;
    self.imageView.centerX = self.centerX;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height -  self.titleLabel.y;
    
}

@end
