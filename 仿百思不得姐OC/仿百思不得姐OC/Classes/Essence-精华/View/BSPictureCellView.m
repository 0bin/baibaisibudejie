//
//  BSPictureCellView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/22.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import <UIImageView+WebCache.h>

#import "BSPictureCellView.h"
#import "BSTextDataModel.h"


@interface BSPictureCellView () 
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet UIButton *seeButtom;

@end
@implementation BSPictureCellView

+(instancetype)pictureView {
    
    return [[NSBundle mainBundle]loadNibNamed:@"BSPictureCellView" owner:nil options:nil].lastObject;
}

- (void)setModel:(BSTextDataModel *)model {

    _model = model;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.image0]];
}


- (void)awakeFromNib {

    [self setAutoresizingMask:UIViewAutoresizingNone];
}

@end
