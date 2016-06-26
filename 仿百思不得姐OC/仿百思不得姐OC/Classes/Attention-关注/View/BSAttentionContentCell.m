//
//  BSAttentionContentCell.m
//  项目集合
//
//  Created by LinBin on 16/6/25.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSAttentionContentCell.h"
#import "BSAttentionUserModel.h"
#import <UIImageView+WebCache.h>

@interface BSAttentionContentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@end

@implementation BSAttentionContentCell


- (void)setModel:(BSAttentionUserModel *)model
{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.header]];
     self.nameLabel.text = model.screen_name;
    self.subTitle.text = [NSString stringWithFormat:@"%ld人订阅",(long)model.fans_count];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)RSSButton:(UIButton *)sender {
}

@end
