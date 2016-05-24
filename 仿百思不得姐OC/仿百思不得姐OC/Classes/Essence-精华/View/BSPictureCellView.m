//
//  BSPictureCellView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/22.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

#import "BSPictureCellView.h"
#import "BSTextDataModel.h"



@interface BSPictureCellView () 
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet UIButton *seeButton;
@property (weak, nonatomic) IBOutlet SVProgressHUD *progress;



@end
@implementation BSPictureCellView

+(instancetype)pictureView {
    
    return [[NSBundle mainBundle]loadNibNamed:@"BSPictureCellView" owner:nil options:nil].lastObject;
}

- (void)setModel:(BSTextDataModel *)model {

    _model = model;
    
    
    //通过图片扩展名判断是否为gif
    NSString *gif = model.image0.pathExtension;
    self.gif.hidden = ![gif isEqualToString:@"gif"];
    
    //
    if (model.isLongPicture == YES) {
        self.seeButton.hidden = NO;
        
    } else {
        self.seeButton.hidden = YES;
    }
    
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
       CGFloat progressFloat = 1.0 * receivedSize / expectedSize;
        
        [SVProgressHUD showProgress:progressFloat status:@"正在下载"];
       
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
    }];
}


- (void)awakeFromNib {

    [self setAutoresizingMask:UIViewAutoresizingNone];
}

@end
