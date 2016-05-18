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
#import "UIView+LBFrameExtension.h"
#import "BSEssenceALLTableController.h"
#import "BSTextTableViewController.h"

#define childVCCount 7

@interface BSEssenceViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *titleScroll;
@property (weak, nonatomic) UIScrollView *contentScroll;
@property (weak, nonatomic) UIView *indicatorView;
@property (strong, nonatomic) UIButton *selelctorButton;
@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigation];
    [self addContentScrollView];
    [self addChildVCWithContentScrollView];
    [self addTitleScrollView];
    

    [self scrollViewDidEndScrollingAnimation:self.contentScroll];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}

- (void)leftButtonClick {

     NSLog(@"-----------------------");
}



/**
 *   内容视图容器Content scroll
 */
- (void)addContentScrollView {
    
    UIScrollView *contentScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [contentScroll setBackgroundColor:[UIColor blueColor]];
    [contentScroll setContentSize:CGSizeMake(childVCCount * self.view.width, 0)];
    [self.view addSubview:contentScroll];
    self.contentScroll = contentScroll;
    [contentScroll setPagingEnabled:YES];
    [self.contentScroll setDelegate:self];
}



/**
 *  添加头部滚动视图title scroll
 */
- (void)addTitleScrollView {

    CGFloat scrollW = self.view.width;
    CGFloat scrollH = 36;
    CGFloat scrollY = 64;
    CGFloat titleW = 80;
    UIScrollView *titleScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, scrollY,scrollW, scrollH)];
    [titleScroll setBackgroundColor:[UIColor grayColor]];
    [titleScroll setContentSize:CGSizeMake(childVCCount * titleW, 0)];
    [titleScroll setBounces:NO];
    self.titleScroll = titleScroll;
    [self.view addSubview:titleScroll];
    
//添加button
    for (NSInteger i = 0; i < childVCCount; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * titleW, 0, titleW, scrollH)];
        [button setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
//        [button layoutIfNeeded];
        [button.titleLabel sizeToFit];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [titleScroll addSubview:button];
   
    }
//添加button底部红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    [indicatorView setBackgroundColor:[UIColor redColor]];
    indicatorView.height = 3;
    indicatorView.y = self.titleScroll.height - 3;
    [titleScroll addSubview:indicatorView];
    self.indicatorView = indicatorView;
    [self buttonClick:self.titleScroll.subviews.firstObject];

}


/**
 *  titleScroll 内的button点击
 */
- (void)buttonClick:(UIButton *)button {
 
//    //选中
//    self.selelctorButton.selected = NO;
//    button.selected = YES;
//    self.selelctorButton = button;
    //设置button点击后不可用为红色，防止重复点击
    self.selelctorButton.enabled = YES;
    button.enabled = NO;
    self.selelctorButton = button;
    
    //点击titlescroll的button 跳转到对象的内容
    CGFloat offsetX = button.tag * self.contentScroll.width;
    [self.contentScroll setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.width = self.selelctorButton.titleLabel.width;
        self.indicatorView.centerX = self.selelctorButton.centerX;
    }];
    
}



/**
 *   往容器内添加控制器
 */
- (void)addChildVCWithContentScrollView {
    
    BSEssenceALLTableController *allTable = [[BSEssenceALLTableController alloc] init];
    [allTable setTitle:@"全部"];
    [self addChildViewController:allTable];
    
    BSTextTableViewController *text = [[BSTextTableViewController alloc] init];
    [text setTitle:@"text"];
    [self addChildViewController:text];
    
    BSEssenceALLTableController *three = [[BSEssenceALLTableController alloc] init];
    [three setTitle:@"three"];
    [self addChildViewController:three];
    
    BSEssenceALLTableController *four = [[BSEssenceALLTableController alloc] init];
    [four setTitle:@"four"];
    [self addChildViewController:four];
    
    BSEssenceALLTableController *five = [[BSEssenceALLTableController alloc] init];
    [five setTitle:@"five"];
    [self addChildViewController:five];
    
    BSEssenceALLTableController *six = [[BSEssenceALLTableController alloc] init];
    [six setTitle:@"six"];
    [self addChildViewController:six];
    
    BSEssenceALLTableController *seven = [[BSEssenceALLTableController alloc] init];
    [seven setTitle:@"seven"];
    [self addChildViewController:seven];
    
    
    
}

/**
 *  设置导航栏细节
 */
- (void)setNavigation {
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]]];
    
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

}



#pragma mark - UIScrollViewDelegate
/**
 *  点击移动动画停止调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    //添加控制器对应的视图
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    BSEssenceALLTableController *all = self.childViewControllers[index];
    [all.view setFrame:CGRectMake(scrollView.contentOffset.x, 0, scrollView.width, scrollView.height)];
    [all.tableView setContentInset:UIEdgeInsetsMake(CGRectGetMaxY(self.titleScroll.frame), 0, self.tabBarController.tabBar.height, 0)];
    [self.contentScroll addSubview:all.view];
    
    //设置button点击居中
    UIButton *button = self.titleScroll.subviews[index];
    CGFloat buttonX = button.centerX - scrollView.width * 0.5;
    if (buttonX < 0 ) {
        buttonX = 0;
    }
    
    if (buttonX > self.titleScroll.contentSize.width - scrollView.width) {
        buttonX = self.titleScroll.contentSize.width - scrollView.width;
    }
    [self.titleScroll setContentOffset:CGPointMake(buttonX,0) animated:YES];


}

/**
 *  手势拖动停止调用
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self buttonClick:self.titleScroll.subviews[index]];

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
