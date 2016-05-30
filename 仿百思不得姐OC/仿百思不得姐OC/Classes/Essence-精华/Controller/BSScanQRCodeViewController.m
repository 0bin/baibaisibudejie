//
//  BSScanQRCodeViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSScanQRCodeViewController.h"
#import "UIView+LBFrameExtension.h"


@interface BSScanQRCodeViewController ()

@property (weak, nonatomic) IBOutlet UITabBar *QRCodetabBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;



@end

@implementation BSScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.QRCodetabBar setSelectedItem:self.QRCodetabBar.items[0]];
    

    [UIView animateWithDuration:5.0 animations:^{
        
        
    }];
    

    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
