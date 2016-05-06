//
//  BSSettingGuideView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/6.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSSettingGuideView.h"

@implementation BSSettingGuideView
- (IBAction)knowButton:(UIButton *)sender {
}

+ (instancetype)guideView {

    return [[NSBundle mainBundle] loadNibNamed:@"BSSettingGuideView" owner:nil options:nil].lastObject;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
