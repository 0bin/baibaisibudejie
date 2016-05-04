//
//  BSEssenceViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "UIView+LBFrameExtension.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"

@interface BSEssenceViewController ()

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]]];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

    
}

- (void)leftButtonClick {

     NSLog(@"-----------------------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIViewController *vc = [[UIViewController alloc] init];
    [vc.view setBackgroundColor:[UIColor redColor]];
    [self.navigationController pushViewController:vc animated:YES];
    

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
