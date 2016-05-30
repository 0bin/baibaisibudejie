//
//  BSNewViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSNewViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"

@interface BSNewViewController ()

@end

@implementation BSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    UIView *red = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [red setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:red];
    
    [UIView animateWithDuration:5.0 animations:^{
        
        [red setFrame:CGRectMake(100, 300, 100, 100)];
    }];
    
}

- (void)leftButtonClick {
    
    NSLog(@"-----------------------");
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
