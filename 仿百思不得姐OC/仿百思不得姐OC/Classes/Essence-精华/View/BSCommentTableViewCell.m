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
#import <UIImageView+WebCache.h>
#import "UIImage+BBBImageCategory.h"

@interface BSCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end



@implementation BSCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
}

- (void)setModel:(BSCommentModel *)model {
    _model = model;
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] ellipseImage];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.user.profile_image]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.iconImage.image = image ? [image ellipseImage] : placeholder;
    }];
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
