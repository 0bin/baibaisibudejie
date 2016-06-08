//
//  BSCommentTableViewCell.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/3.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSCommentTableViewCell.h"
#import "BSUserModel.h"
#import "BSCommentModel.h"

#import "UIImageView+BBBImageViewCategory.h"

@interface BSCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end



@implementation BSCommentTableViewCell
/**
 *  设置menu
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
}

- (void)setModel:(BSCommentModel *)model {
    _model = model;
    
    [self.iconImage setEllipseIconWithUrl:model.user.profile_image];
       self.contentLabel.text = model.content;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)model.like_count];
    self.nameLabel.text = model.user.username;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)zanButton:(UIButton *)sender {
    
}

@end
