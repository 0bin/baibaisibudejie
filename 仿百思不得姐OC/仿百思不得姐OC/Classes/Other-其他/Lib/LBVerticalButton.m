//
//  LBVerticalButton.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/8.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBVerticalButton.h"
#import "UIView+LBFrameExtension.h"

@implementation LBVerticalButton

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
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;

}



@end
