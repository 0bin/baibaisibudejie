//
//  BSLoginViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/5.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSLoginViewController.h"

@interface BSLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *PSWTF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLaoutLeft;

@end

@implementation BSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //returnKey 当输入为空时 禁止点击
    self.accountTF.enablesReturnKeyAutomatically = YES;
    self.PSWTF.enablesReturnKeyAutomatically = YES;
    //占位字体属性设置：
    NSMutableDictionary *attributed = [NSMutableDictionary dictionary];
    attributed[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:attributed];
    self.PSWTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:attributed];
}
- (IBAction)dismissButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)rigesterButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (self.loginLaoutLeft.constant == 0) {
        self.loginLaoutLeft.constant = - self.view.bounds.size.width;
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
    } else {
        self.loginLaoutLeft.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    
    }

    [UIView animateWithDuration:0.6 animations:^{
        [self.view layoutIfNeeded];
    }];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.accountTF) {
        [self.PSWTF becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
    return YES;

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
