//
//  BSTextTableViewCell.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/19.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIImageView+WebCache.h>

#import "BSTextTableViewCell.h"
#import "BSTextDataModel.h"
#import "UIView+LBFrameExtension.h"



@interface BSTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;


@end


@implementation BSTextTableViewCell

+ (instancetype)cell{

    BSTextTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"BSTextTableViewCell" owner:nil options:nil].lastObject;
    return cell;

}


- (void)setTextData:(BSTextDataModel *)textData {

    _textData = textData;
   
    [self.icon sd_setImageWithURL:[NSURL URLWithString:textData.profile_image]];
    self.nameLabel.text = textData.name;
    self.timeLabel.text = textData.create_time;
    [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",textData.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",textData.cai] forState:UIControlStateNormal];
    [self.shareButton setTitle:[NSString stringWithFormat:@"%zd",textData.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%zd",textData.comment] forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
  
    [super setFrame:frame];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
