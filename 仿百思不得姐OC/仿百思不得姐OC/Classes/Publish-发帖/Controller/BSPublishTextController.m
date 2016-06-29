//
//  BSPublishTextController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/9.
//  Copyright © 2016年 LinBin. All rights reserved.
//



#import "BSPublishTextController.h"
#import "BSPlaceholderTextView.h"
#import "BSPublishTool.h"
#import "UIView+LBFrameExtension.h"

@interface BSPublishTextController () <UITextViewDelegate>
/**
 *  <#Description#>
 */
@property (weak, nonatomic) BSPublishTool *tool;
@end

@implementation BSPublishTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self setTextView];
    [self addTool];
    

    
}

- (void)addTool
{
    BSPublishTool *tool = [BSPublishTool tool];
    tool.width = self.view.width;
    tool.x = 0;
    tool.y = self.view.height - tool.height;
    
    
    [self.view addSubview:tool];
    self.tool = tool;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardChange:(NSNotification *)notify
{
    CGRect kbFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
            [self.tool setTransform:CGAffineTransformMakeTranslation(0, kbFrame.origin.y - [UIScreen mainScreen].bounds.size.height )];
    }];
    
}


/**
 *  设置textView
 */
- (void)setTextView
{
    BSPlaceholderTextView *textView = [[BSPlaceholderTextView alloc] init];
    textView.delegate = self;
    textView.frame = self.view.bounds;
    textView.placeholder = @"xxxxxxxxxxxxxxooooo占位";
//    textView.inputAccessoryView = [BSPublishTool initWithFromXib];
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

#pragma mark - textView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
