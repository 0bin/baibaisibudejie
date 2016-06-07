//
//  UIImage+BBBImageCategory.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/7.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "UIImage+BBBImageCategory.h"

@implementation UIImage (BBBImageCategory)

- (UIImage *)ellipseImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    
    UIImage *ellipseImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return ellipseImage;

}

@end
