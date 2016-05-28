//
//  BSVedioView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/26.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import <objc/runtime.h>
#import "BSVedioView.h"
#import "BSTextDataModel.h"

@interface BSVedioView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end
@implementation BSVedioView

+ (instancetype)vedioView {
    
    BSVedioView *vedioView = [[NSBundle mainBundle]loadNibNamed:@"BSVedioView" owner:nil options:nil].lastObject;
    return vedioView;
    
}


- (void)awakeFromNib {
    
    [self setAutoresizingMask:UIViewAutoresizingNone];

    
}

- (void)setModel:(BSTextDataModel *)model {
    
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image0]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放",(long)model.playcount];
    NSInteger minute = model.videotime / 60;
    NSInteger second = model.videotime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%ld分%ld秒",(long)minute,(long)second];
    
}

@end
