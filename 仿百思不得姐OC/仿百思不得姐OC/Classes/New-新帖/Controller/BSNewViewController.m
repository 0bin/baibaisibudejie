//
//  BSNewViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSNewViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "UIView+LBFrameExtension.h"
#import "BBBLabel.h"
#import "BBBScrollLayout.h"
#import "BBBCustomCollectionCell.h"
#import "BBBRoundLayout.h"
#import "BSWaterfallController.h"
#import "BBBWaterfallLayout.h"


@interface BSNewViewController () <UICollectionViewDataSource,UICollectionViewDelegate,BBBWaterfallLayoutDelegate,UICollectionViewDelegateFlowLayout>
/**
 *  水平collection
 */
@property (weak, nonatomic) UICollectionView *collecionView;
/**
 *  垂直瀑布collection
 */
@property (weak, nonatomic) UICollectionView *collecionWaterfall;


@end

@implementation BSNewViewController

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
static NSString *const cvCell = @"collectCell";
static CGFloat const HorizontalCollectionH = 300;
static CGFloat const HorizontalCollectionY = 66;

static CGFloat const VerticalCollectionY = HorizontalCollectionY + HorizontalCollectionH + 10;
static CGFloat const VerticalCollectionH = 230;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setNav];
    [self setHorizontalCollection];
    [self setVerticalCollection];

    self.automaticallyAdjustsScrollViewInsets = NO;
   
}


/**
 *  垂直瀑布流
 */
- (void)setVerticalCollection
{
    BBBWaterfallLayout *layout = [[BBBWaterfallLayout alloc] init];
    layout.delegate = self;
    CGRect frame = CGRectMake(0, VerticalCollectionY, kScreenW, VerticalCollectionH);
    UICollectionView *vCollect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [vCollect setDataSource:self];
    [vCollect setDelegate:self];
    [vCollect setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:vCollect];
    self.collecionWaterfall = vCollect;
    [vCollect registerNib:[UINib nibWithNibName:@"BBBCustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:cvCell];
}

/**
 *  设置collection水平轮播
 */
- (void)setHorizontalCollection
{
    BBBScrollLayout *layout = [[BBBScrollLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenW * 0.6, HorizontalCollectionH * 0.9);
    
    CGRect frame = CGRectMake(0, HorizontalCollectionY, kScreenW, HorizontalCollectionH);
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [collect setDataSource:self];
    [collect setDelegate:self];
    [collect setBackgroundColor:[UIColor blackColor]];
//    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cvCell];
    [collect registerNib:[UINib nibWithNibName:@"BBBCustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:cvCell];
    [self.view addSubview:collect];
    self.collecionView = collect;
    
}

/**
 *  导航栏设置
 */
- (void)setNav
{
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    UIButton *button = [[UIButton alloc] init];
    button.size = CGSizeMake(60, 30);
    [button setTitle:@"change" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickButtonChange) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:button];
}
/**
 *  点击按钮改变collection布局模式
 */
- (void)clickButtonChange
{
    if ([self.collecionView.collectionViewLayout isKindOfClass:[BBBScrollLayout class]]) {
        [self.collecionView setCollectionViewLayout:[[BBBRoundLayout alloc] init] animated:YES];
    } else {
        BBBScrollLayout *layout = [[BBBScrollLayout alloc] init];
        layout.itemSize = CGSizeMake(kScreenW * 0.6, HorizontalCollectionH * 0.9);
        [self.collecionView setCollectionViewLayout:layout animated:YES];
    }
}

/**
 *  点击按钮跳转下个界面
 */
- (void)leftButtonClick {
    
    BSWaterfallController *waterfall = [[BSWaterfallController alloc] init];
    [self.navigationController pushViewController:waterfall animated:YES];
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 46;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBBCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvCell forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item ];
    return  cell;

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}

#pragma mark - BBBWaterfallLayoutDelegate
- (CGFloat)waterfallLayout:(BBBWaterfallLayout *)waterfallLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    NSString *imageName = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    UIImage *image = [UIImage imageNamed:imageName];
    return itemWidth * image.size.height / image.size.width;

}

- (NSUInteger)columnCountInWaterfallLayout:(BBBWaterfallLayout *)waterfallLayout
{
    return 4;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0;
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
