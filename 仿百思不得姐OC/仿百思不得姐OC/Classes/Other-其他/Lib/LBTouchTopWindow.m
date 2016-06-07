//
//  LBTouchTopWindow.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/5.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBTouchTopWindow.h"
#import "UIView+LBFrameExtension.h"

@implementation LBTouchTopWindow

static UIWindow *window_;


+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.backgroundColor = [UIColor redColor];    
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTopWindow)]];
    [window_ setRootViewController:[[UIViewController alloc] init]];
}

+ (void)show
{
    window_.hidden = NO;
    
}

+ (void)hidden
{
    window_.hidden = YES;
}

+ (void)touchTopWindow
{    NSLog(@"-----------------------");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewWithView:window];



}

+ (void)searchScrollViewWithView:(UIView *)view
{
    

    for (UIScrollView *scroll  in view.subviews)
    {
        if ([scroll isKindOfClass:[UIScrollView class]] && [scroll isShowingOnKeyWindow])
        {
            [scroll setContentOffset:CGPointZero animated:YES];
        }
        [self searchScrollViewWithView:scroll];
    }
}
@end
