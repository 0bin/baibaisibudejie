//
//  BSPublishTextController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/9.
//  Copyright © 2016年 LinBin. All rights reserved.
//



#import "BSPublishTextController.h"
#import "BSPlaceholderTextView.h"

@interface BSPublishTextController ()

@end

@implementation BSPublishTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self setTextView];
    

    
    
}

/**
 *  设置textView
 */
- (void)setTextView
{
    BSPlaceholderTextView *textView = [[BSPlaceholderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"xxxxxxxxxxxxxxooooo占位ooooooooxoxxxxxxxxxdsdfdsfdfjksjfkjdfjkdsjfklsjldfjldksjflksdjflkjsdlkfj";
    [self.view addSubview:textView];

}

/**
 *  设置导航栏
 */
- (void)setNavigation
{
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(publishButton)];
    self.title = @"发帖子";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    //强制刷新 检测button状态
    [self .navigationController.navigationBar layoutIfNeeded];

}



- (void)cancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)publishButton
{
     NSLog(@"--------------publish---------");
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
