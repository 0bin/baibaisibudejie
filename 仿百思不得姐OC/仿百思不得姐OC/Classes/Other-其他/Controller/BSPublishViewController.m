//
//  BSPublishViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/8.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSPublishViewController.h"
#import "LBVerticalButton.h"
#import <pop/POP.h>
#import "UIView+LBFrameExtension.h"

@interface BSPublishViewController ()



@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//数据
    NSArray *imageNames = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *buttonTitles = @[@"视频", @"图片", @"段子", @"声音", @"审帖", @"离线下载"];
    
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSInteger buttomNumber = 6;
    NSInteger column = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat cloumnMargin = (screenW - column * buttonW) / (column + 1);
    CGFloat buttonStartY = (screenH - buttonH * 2) * 0.5;
//添加button
    for (NSInteger i = 0; i < buttomNumber; i++) {
        LBVerticalButton *button = [[LBVerticalButton alloc] init];
        button.imageView.image = [UIImage imageNamed:imageNames[i]];
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
        CGFloat buttonX = cloumnMargin + i % column * (buttonW + cloumnMargin) ;
        CGFloat buttonY = i / column * buttonH + buttonStartY;
        [button addTarget:self action:@selector(publishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW,buttonH)];
        [self.view addSubview:button];
//设置button动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - screenH, buttonW, buttonH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];;
        animation.springSpeed = 5;
        animation.springBounciness = 5;
        animation.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:animation forKey:nil];
    }
    
//添加宣传语并设置动画
    UIImageView *slogan = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:slogan];
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(screenW * 0.5, screenH * 0.2 - screenH)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(screenW * 0.5, screenH * 0.2)];
    animation.springBounciness = 5;
    animation.springSpeed = 5;
    animation.beginTime = CACurrentMediaTime() + imageNames.count * 0.1;
    [slogan pop_addAnimation:animation forKey:nil];

    
}


/**
 *  button点击
 */
- (void)publishButtonClick:(UIButton *)button {
      NSLog(@"%s",__func__);

}


/**
 *  取消按钮点击
 */
- (IBAction)cancelButtonClick:(UIButton *)sender {
    NSInteger index = 2;
    for (NSInteger i = index; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, view.centerY)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, view.centerY + self.view.height)];
        animation.beginTime = CACurrentMediaTime() + i * 0.1;
        [view pop_addAnimation:animation forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finish) {
                  [self dismissViewControllerAnimated:NO completion:nil];
                
            }];
          
        }
    }

    
    

    
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
