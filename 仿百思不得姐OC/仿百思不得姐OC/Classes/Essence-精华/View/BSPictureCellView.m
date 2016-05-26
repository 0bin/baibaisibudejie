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
#import "LBProgressView.h"
#import "BSPictureFullScreenViewController.h"



@interface BSPictureCellView () 
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet UIButton *seeButton;
@property (weak, nonatomic) IBOutlet LBProgressView *progress;



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
    
    //是否大图
    if (model.isLongPicture == YES) {
        self.seeButton.hidden = NO;
        
    } else {
        self.seeButton.hidden = YES;
    }
    
    //显示图片及progress
    [self.picture sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
       CGFloat progressFloat = 1.0 * receivedSize / expectedSize;
        [self.progress setProgress:progressFloat animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [self.progress setHidden:YES];
        if (model.isLongPicture == YES) {
            //开启内容上下文
            UIGraphicsBeginImageContextWithOptions(model.pictureFrame.size, YES, 0.0);
            CGFloat drawW = model.pictureFrame.size.width;
            CGFloat drawH = drawW * image.size.height / image.size.width;
            //画比例缩放全图
            [image drawInRect:CGRectMake(0, 0, drawW, drawH)];
            self.picture.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    
    }];
}



- (void)awakeFromNib {

    [self setAutoresizingMask:UIViewAutoresizingNone];
    [self.picture setUserInteractionEnabled:YES];
    [self.picture addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureClick:)]];
}

- (void)pictureClick:(UITapGestureRecognizer *)tap {
    BSPictureFullScreenViewController *fullPicture = [[BSPictureFullScreenViewController alloc]init];
    fullPicture.modle = self.model;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:fullPicture animated:YES completion:nil];

}
@end
