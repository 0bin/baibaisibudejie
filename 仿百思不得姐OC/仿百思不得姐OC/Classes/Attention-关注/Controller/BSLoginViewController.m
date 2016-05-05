//
//  BSLoginViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/5.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSLoginViewController.h"

@interface BSLoginViewController ()

@end

@implementation BSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dismissButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)rigesterButton:(UIButton *)sender {
}
- (IBAction)loginButton:(UIButton *)sender {
    
//    sender.layer.cornerRadius = 5;
//    sender.layer.masksToBounds = YES;
}

- (IBAction)forgotPSW:(UIButton *)sender {
}

- (IBAction)loginQQ:(UIButton *)sender {
}

- (IBAction)loginSina:(UIButton *)sender {
}

- (IBAction)loginQQWeibo:(UIButton *)sender {
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
