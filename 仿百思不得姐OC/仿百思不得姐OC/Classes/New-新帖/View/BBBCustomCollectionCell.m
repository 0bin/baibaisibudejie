//
//  BBBCustomCollectionCell.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/16.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBCustomCollectionCell.h"

@interface BBBCustomCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation BBBCustomCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //(__bridge CGColorRef _Nullable)([UIColor whiteColor])
    self.imageV.layer.borderColor = [[UIColor whiteColor] CGColor];;
    self.imageV.layer.borderWidth = 2;
}

- (void)setImageName:(NSString *)imageName
{
    
    self.imageV.image = [UIImage imageNamed:imageName];
}

@end
