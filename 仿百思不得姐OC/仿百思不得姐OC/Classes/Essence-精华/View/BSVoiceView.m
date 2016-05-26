//
//  BSVoiceView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/25.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import "BSVoiceView.h"
#import "BSTextDataModel.h"

@interface BSVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
@implementation BSVoiceView


+ (instancetype)voiceView {

    BSVoiceView *voiceView = [[NSBundle mainBundle]loadNibNamed:@"BSVoiceView" owner:nil options:nil].lastObject;
    return voiceView;

}


- (void)awakeFromNib {

    [self setAutoresizingMask:UIViewAutoresizingNone];
}

- (void)setModel:(BSTextDataModel *)model {

    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image0]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%ld播放",(long)model.playcount];
    NSInteger minute = model.voicetime / 60;
    NSInteger second = model.voicetime % 60;
    self.playTimeLabel.text = [NSString stringWithFormat:@"%ld分%ld秒",(long)minute,(long)second];
 
}

@end
