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
#import "NSDate+LBDate.h"
#import "BSPictureCellView.h"



@interface BSTextTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sinav;

/** 图片view */
@property (weak, nonatomic) BSPictureCellView *pictureView;

@end


@implementation BSTextTableViewCell
/**
 *  加载cell；
 */
+ (instancetype)cell{
    BSTextTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"BSTextTableViewCell" owner:nil options:nil].lastObject;
    return cell;
}

/**
 *  加载pictureview
 */
- (BSPictureCellView *)pictureView {

    if (_pictureView == nil) {
        BSPictureCellView *pictureView = [BSPictureCellView pictureView];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
    }
    return _pictureView;
}


/**
 *  设置cell数据
 */
- (void)setTextData:(BSTextDataModel *)textData {
    _textData = textData;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:textData.profile_image]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = textData.name;
    self.timeLabel.text = textData.create_time;
    self.sinav.hidden = !textData.isSina_v;
    self.contentLabel.text = textData.text;

    [self setButtonTitleWithButton:self.dingButton count:textData.ding palceHolder:@"顶"];
    [self setButtonTitleWithButton:self.caiButton count:textData.cai palceHolder:@"踩"];
    [self setButtonTitleWithButton:self.shareButton count:textData.repost palceHolder:@"转发"];
    [self setButtonTitleWithButton:self.commentButton count:textData.comment palceHolder:@"评论"];
    
    if (textData.type == BSBasicTypePicture) {
        self.pictureView.model = textData;
        self.pictureView.frame = textData.pictureFrame;
    }

}

/**
 *  判断数量 为0 显示顶 ， >10000显示万
 */
- (void)setButtonTitleWithButton:(UIButton *)button count:(NSInteger)count palceHolder:(NSString *)placeHolder{

    if (count > 10000) {
        placeHolder = [NSString stringWithFormat:@"%.1ld万",count/10000];
    } else if (count > 0) {
    
        placeHolder = [NSString stringWithFormat:@"%ld",(long)count];
    }
    [button setTitle:placeHolder forState:UIControlStateNormal];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    [self setAutoresizingMask:UIViewAutoresizingNone];
}

/**
 *  设置cell边距
 */
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
