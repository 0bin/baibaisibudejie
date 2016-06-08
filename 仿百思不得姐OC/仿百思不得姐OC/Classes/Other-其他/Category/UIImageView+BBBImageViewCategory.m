//
//  UIImageView+BBBImageViewCategory.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/7.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "UIImageView+BBBImageViewCategory.h"
#import "UIImage+BBBImageCategory.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (BBBImageViewCategory)
/**
 *  设置圆形头像
 *
 *  @param url 头像地址
 */
- (void)setEllipseIconWithUrl:(NSString *)url
{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] ellipseImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image ellipseImage] : placeholder;
    }];


}

/**
 *  设置原始头像
 *
 *  @param url 头像地址
 */
- (void)setIconWithUrl:(NSString *)url
{

    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? image : placeholder;
    }];

}

@end
