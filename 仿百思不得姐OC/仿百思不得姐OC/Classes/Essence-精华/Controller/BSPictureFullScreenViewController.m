//
//  BSPictureFullScreenViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/25.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "BSPictureFullScreenViewController.h"
#import "BSTextDataModel.h"
#import "UIView+LBFrameExtension.h"
#import "LBProgressView.h"

@interface BSPictureFullScreenViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/** 图片显示*/
@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet LBProgressView *progressView;

@end

@implementation BSPictureFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGFloat screenW =[UIScreen mainScreen].bounds.size.width;
    CGFloat screenH =[UIScreen mainScreen].bounds.size.height;
    
    [self.progressView setProgress:self.modle.progressFloat animated:NO];
    UIImageView *pictureView = [[UIImageView alloc] init];
    [pictureView sd_setImageWithURL:[NSURL URLWithString:self.modle.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.modle.progressFloat = receivedSize / expectedSize * 1.0;
        [self.progressView setProgress:self.modle.progressFloat animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.progressView setHidden:YES];
        
    }];
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.modle.height / self.modle.width;
    if (pictureH > screenH) { //超出屏幕高度
        [pictureView setFrame:CGRectMake(0, 0, pictureW, pictureH)];
        [self.scrollView setContentSize:CGSizeMake(0, pictureH)];
    } else {
        pictureView.size = CGSizeMake(pictureW, pictureH);
        pictureView.centerX = screenW * 0.5;
        pictureView.centerY = screenH * 0.5;
    }
    [pictureView setUserInteractionEnabled:YES];
    [pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelButtonClick:)]];
    [self.scrollView addSubview:pictureView];
    self.imageView = pictureView;
    
}


- (IBAction)cancelButtonClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)shareButtonClick:(UIButton *)sender {
}


- (IBAction)saveButtonClick:(UIButton *)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片未加载完成"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [SVProgressHUD showSuccessWithStatus:@"保存成功"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
