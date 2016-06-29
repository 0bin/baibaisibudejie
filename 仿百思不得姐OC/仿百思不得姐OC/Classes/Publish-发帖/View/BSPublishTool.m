//
//  BSPublishTool.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/13.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSPublishTool.h"
#import "UIView+LBFrameExtension.h"

@interface BSPublishTool ()

@property (weak, nonatomic) IBOutlet UIView *toolTopView;

@end

@implementation BSPublishTool

+ (instancetype)tool
{
   return [[NSBundle mainBundle] loadNibNamed:@"BSPublishTool" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    UIButton *addButton = [[UIButton alloc] init];
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addButton setFrame:CGRectMake(10, 10, addButton.currentImage.size.width, addButton.currentImage.size.height)];
    [self.toolTopView addSubview:addButton];
    
    

}

@end
