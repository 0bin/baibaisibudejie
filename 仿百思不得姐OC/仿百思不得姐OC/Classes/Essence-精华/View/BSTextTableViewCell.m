//
//  BSTextTableViewCell.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/19.
//  Copyright © 2016年 LinBin. All rights reserved.
//



#import "BSTextTableViewCell.h"
#import "BSTextDataModel.h"
#import "UIView+LBFrameExtension.h"
#import "NSDate+LBDate.h"
#import "BSPictureCellView.h"
#import "BSVoiceView.h"
#import "BSVedioView.h"
#import "BSCommentModel.h"
#import "BSUserModel.h"
#import "UIImageView+BBBImageViewCategory.h"



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
/** 图片view */
@property (weak, nonatomic) BSVoiceView *voiceView;
/** 图片view */
@property (weak, nonatomic) BSVedioView *vedioView;
/** 评论背景 */
@property (weak, nonatomic) IBOutlet UIView *commentBackground;
/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *commentLabe;
@end


@implementation BSTextTableViewCell
/**
 *  加载cell；
 */
+ (instancetype)cell{
    BSTextTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"BSTextTableViewCell" owner:nil options:nil].lastObject;
    return cell;
}
- (IBAction)reportButton:(UIButton *)sender {
    
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];

    
    
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
 *  加载voiceview
 */
- (BSVoiceView *)voiceView{
    
    if (_voiceView == nil) {
        BSVoiceView *voiceView = [BSVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    return _voiceView;
}

/**
 *  加载vedioView
 */
- (BSVedioView *)vedioView{
    
    if (_vedioView == nil) {
        BSVedioView *vedioView = [BSVedioView vedioView];
        [self.contentView addSubview:vedioView];
        self.vedioView = vedioView;
    }
    return _vedioView;
}

/**
 *  设置cell数据
 */
- (void)setTextData:(BSTextDataModel *)textData {
    
    _textData = textData;
    
    
    [self.icon setEllipseIconWithUrl:textData.profile_image];


    self.nameLabel.text = textData.name;
    self.timeLabel.text = textData.created_at;
    self.sinav.hidden = !textData.isSina_v;
    self.contentLabel.text = textData.text;

    [self setButtonTitleWithButton:self.dingButton count:textData.ding palceHolder:@"顶"];
    [self setButtonTitleWithButton:self.caiButton count:textData.cai palceHolder:@"踩"];
    [self setButtonTitleWithButton:self.shareButton count:textData.repost palceHolder:@"转发"];
    [self setButtonTitleWithButton:self.commentButton count:textData.comment palceHolder:@"评论"];
    
    if (textData.type == BSBasicTypePicture) {
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
        self.pictureView.model = textData;
        self.pictureView.frame = textData.pictureFrame;
        
    } else if (textData.type == BSBasicTypeVoice) {
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.vedioView.hidden = YES;
        self.voiceView.model = textData;
        self.voiceView.frame = textData.voiceFrame;
        
    } else if (textData.type == BSBasicTypeVedio) {
        self.vedioView.model = textData;
        self.vedioView.frame = textData.vedioFrame;
        self.vedioView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
    } else {
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;

    }
    NSArray *array = textData.top_cmt;
    BSCommentModel *comment = array.firstObject;

    if (comment) {
        self.commentLabe.text = [NSString stringWithFormat:@"%@:%@", comment.user.username,comment.content] ;
        self.commentBackground.hidden = NO;
    } else {
        self.commentBackground.hidden = YES;
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
    frame.size.height = self.textData.cellHeight - margin;
    frame.origin.y += margin;
  
    [super setFrame:frame];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
