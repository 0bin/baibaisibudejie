//
//  LBPopoverViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBPopoverViewController.h"

@interface LBPopoverViewController ()<UIViewControllerTransitioningDelegate>


@end

@implementation LBPopoverViewController
+ (instancetype)popoverView {

    LBPopoverViewController *popoverView = [[LBPopoverViewController alloc]init];
    return popoverView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.transitioningDelegate = self;
    [self setModalPresentationStyle:UIModalPresentationCustom];
    
}
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return <#expression#>

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self dismissViewControllerAnimated:YES completion:nil];
}

//
///**
// *  设置导航右侧按钮点击
// */
//- (void)rightButtonClick:(UIButton *)item {
//    NSInteger count = 3;
//    CGFloat contentViewW = 100;
//    CGFloat buttonH = 44;
//    CGFloat buttonW = contentViewW;
//    CGFloat contentViewH = count * buttonH;
//    NSArray *array = @[@"扫一扫",@"雷达",@"收付款"];
//    CGFloat contentViewX = [UIScreen mainScreen].bounds.size.width - contentViewW ;
//    CGFloat contentViewY = 64;
//    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    [window addSubview:view];
//    self.contentView = view;
//    for (NSInteger i = 0; i < count; i++) {
//        
//        UIButton *button =[[UIButton alloc] init];
//        CGFloat buttonX = 0;
//        CGFloat buttonY = i * buttonH;
//        button.tag = i;
//        [button setBackgroundColor:[UIColor grayColor]];
//        [button setTitle:array[i] forState:UIControlStateNormal];
//        [button setFrame:CGRectMake(buttonX, buttonY, buttonW-1, buttonH-1)];
//        [button addTarget:self action:@selector(contentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [view addSubview:button];
//    }
//    
//    
//}
//
//- (void)contentButtonClick:(UIButton *)button {
//    
//    switch (button.tag) {
//        case 0:
//            
//            NSLog(@"--11111-");
//            [self.contentView removeFromSuperview];
//            break;
//        case 1:
//            NSLog(@"--2222-");
//            [self.contentView removeFromSuperview];
//            break;
//        case 2:
//            NSLog(@"--333-");
//            [self.contentView removeFromSuperview];
//            break;
//            
//        default:
//            break;
//    }
//    
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//    [self.contentView removeFromSuperview];
//}
//
@end
