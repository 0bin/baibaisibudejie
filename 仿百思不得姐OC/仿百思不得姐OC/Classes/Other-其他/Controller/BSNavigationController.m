//
//  BSNavigationController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSNavigationController.h"

@interface BSNavigationController ()

@end

@implementation BSNavigationController
+ (void)initialize {
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置所有的导航栏


}
/**
 *  重写push 统一设置push导航栏
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    if (self.viewControllers.count > 0) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
//        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [button sizeToFit];
//        [button setBackgroundColor:[UIColor blueColor]];
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = item;
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    
    [super pushViewController:viewController animated:animated];


}
/**
 * 导航栏返回按钮点击方法
 */
- (void)backButtonClick {

    [self popViewControllerAnimated:YES];

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
