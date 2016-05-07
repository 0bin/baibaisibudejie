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
    [self removeFromSuperview];
}

+ (instancetype)guideView {
    return [[NSBundle mainBundle] loadNibNamed:@"BSSettingGuideView" owner:nil options:nil].lastObject;
}

+ (void)show {
    
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    NSString *saveVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (![currentVersion isEqualToString: saveVersion]) {
        BSSettingGuideView *guide = [BSSettingGuideView guideView];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [guide setFrame:window.bounds];
        [window addSubview:guide];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
