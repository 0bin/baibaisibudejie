//
//  BSAttentionViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSAttentionViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "BSRecommendViewController.h"
#import "BSLoginViewController.h"



@interface BSAttentionViewController ()

@end

@implementation BSAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

}
/**
 *  导航栏左上角按钮点击方法
 */
- (void)leftButtonClick {
    BSRecommendViewController *recommend = [[BSRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recommend animated:YES];
    
    
}

/**
 *  立刻登陆注册按钮点击方法
 */
- (IBAction)LoginButton {
    
    BSLoginViewController *loginVC = [[BSLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
    
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
