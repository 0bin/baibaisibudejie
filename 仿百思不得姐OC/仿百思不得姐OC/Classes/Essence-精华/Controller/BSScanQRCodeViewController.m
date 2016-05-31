//
//  BSScanQRCodeViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSScanQRCodeViewController.h"
#import "UIView+LBFrameExtension.h"


@interface BSScanQRCodeViewController () <UITabBarDelegate>
/**
 *  tabBar
 */
@property (weak, nonatomic) IBOutlet UITabBar *QRCodetabBar;
/**
 *  内容高度约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
/**
 *  识别网顶部约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *QRViewtopLine;

/**
 *  识别网视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeView;

@end

@implementation BSScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.QRCodetabBar setSelectedItem:self.QRCodetabBar.items[0]];
    [self.QRCodetabBar setDelegate:self];

    
}

- (void)setQRCodeAinimation {
    
//    self.QRViewtopLine.constant = - self.contentViewHeight.constant;
//    [self.QRCodeView layoutIfNeeded];

    [UIView animateWithDuration:3 animations:^{
        [UIView setAnimationRepeatCount:MAXFLOAT];
        self.QRViewtopLine.constant = self.contentViewHeight.constant;
        [self.QRCodeView layoutIfNeeded];
    }];
  
}

//- (void)viewDidAppear:(BOOL)animated {
//    [self setQRCodeAinimation];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setQRCodeAinimation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}
- (IBAction)picture:(UIButton *)sender {
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

//    if (tabBar.selectedItem.tag == 1) {
//        self.contentViewHeight.constant = 300;
//    } else {
//        self.contentViewHeight.constant = 150;
//     
//    }
//
//    [self.QRCodeView.layer removeAllAnimations];
//    [self setQRCodeAinimation];
}


@end
