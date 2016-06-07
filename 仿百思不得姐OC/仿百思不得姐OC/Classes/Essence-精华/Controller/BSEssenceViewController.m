//
//  BSEssenceViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import "BSConst.h"
#import "BSEssenceViewController.h"
#import "UIView+LBFrameExtension.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "UIView+LBFrameExtension.h"
#import "BSEssenceALLTableController.h"
#import "BSBasicTableViewController.h"
#import "BSTextEssenceViewController.h"
#import "LBPopoverView.h"


@interface BSEssenceViewController () <UIScrollViewDelegate>

/** 内容导航栏scroll */
@property (weak, nonatomic) UIScrollView *titleScroll;
/** 内容scroll */
@property (weak, nonatomic) UIScrollView *contentScroll;
/** 导航栏选中指示view */
@property (weak, nonatomic) UIView *indicatorView;
/** 导航栏选中button */
@property (strong, nonatomic) UIButton *selelctorButton;
/** 内容view */
@property (weak, nonatomic) UIView *contentView;

@end



@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//设置导航栏
    [self setNavigation];
//添加内容Scroll
    [self addContentScrollView];
//scroll添加子控制器
    [self addChildVCWithContentScrollView];
//添加内容导航栏
    [self addTitleScrollView];

    [self scrollViewDidEndScrollingAnimation:self.contentScroll];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
}


/**
 *   内容视图容器Content scroll
 */
- (void)addContentScrollView {
    
    UIScrollView *contentScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [contentScroll setBackgroundColor:[UIColor whiteColor]];
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
        [button.titleLabel sizeToFit];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(titleScrollButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [self titleScrollButtonClick:self.titleScroll.subviews.firstObject];

}


/**
 *  titleScroll 内的button点击
 */
- (void)titleScrollButtonClick:(UIButton *)button {
 
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
    
    BSBasicTableViewController *allTable = [[BSBasicTableViewController alloc] init];
    [allTable setTitle:@"全部"];
    allTable.type = BSBasicTypeAll;
    [self addChildViewController:allTable];
    
    BSBasicTableViewController *text = [[BSBasicTableViewController alloc] init];
    [text setTitle:@"段子"];
    text.type = BSBasicTypeText;
    [self addChildViewController:text];
    
    
    BSBasicTableViewController *picture = [[BSBasicTableViewController alloc] init];
    [picture setTitle:@"图片"];
    picture.type = BSBasicTypePicture;
    [self addChildViewController:picture];
    
    BSBasicTableViewController *voice = [[BSBasicTableViewController alloc] init];
    [voice setTitle:@"声音"];
    voice.type = BSBasicTypeVoice;
    [self addChildViewController:voice];
    
    BSBasicTableViewController *vedio = [[BSBasicTableViewController alloc] init];
    [vedio setTitle:@"视频"];
    vedio.type = BSBasicTypeVedio;
    [self addChildViewController:vedio];
    
    BSBasicTableViewController *six = [[BSBasicTableViewController alloc] init];
    six.type = BSBasicTypeAll;
    [six setTitle:@"排行"];
    [self addChildViewController:six];
    
    BSBasicTableViewController *seven = [[BSBasicTableViewController alloc] init];
    [seven setTitle:@"其他"];
    seven.type = BSBasicTypeAll;
    [self addChildViewController:seven];
    
}

/**
 *  设置导航栏细节
 */
- (void)setNavigation {
    
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]]];
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(rightButtonClick:)];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

}

/**
 *  设置导航左侧按钮点击
 */
- (void)leftButtonClick {
    
    BSTextEssenceViewController *text = [[BSTextEssenceViewController alloc] init];
    [self.navigationController pushViewController:text animated:YES];
}

/**
 *  设置导航右侧按钮点击
 */
- (void)rightButtonClick:(UIView *)item {

    LBPopoverView *popover = [LBPopoverView popoverView];

    [popover showPopoverViewFrom:item];

}



#pragma mark - UIScrollViewDelegate
/**
 *  点击移动动画停止调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {


    //添加控制器对应的视图
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    BSEssenceALLTableController *all = self.childViewControllers[index];
    if ([all isViewLoaded]) return;
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
    [self titleScrollButtonClick:self.titleScroll.subviews[index]];

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
