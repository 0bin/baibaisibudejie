//
//  LBSquareButton.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/14.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBSquareButton.h"
#import "UIView+LBFrameExtension.h"
#import "BSMeDataModel.h"
#import <UIButton+WebCache.h>


@interface LBSquareButton ()

@end

@implementation LBSquareButton


- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
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
    
    [super layoutSubviews];
    
    
    self.imageView.width = self.height * 0.5;
    self.imageView.height = self.width * 0.5;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height -  self.titleLabel.y;
    
}
- (void)setModel:(BSMeDataModel *)model {
    _model = model;
    [self sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
    [self setTitle:model.name forState:UIControlStateNormal];
}
@end
