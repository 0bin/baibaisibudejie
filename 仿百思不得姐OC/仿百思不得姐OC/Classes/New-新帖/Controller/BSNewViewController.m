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
#import "BBBVerticalLayout.h"
#import "BBBRoundLayout.h"


@interface BSNewViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  <#Description#>
 */
@property (weak, nonatomic) UICollectionView *collecionView;
@end

@implementation BSNewViewController

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
static NSString *const cvCell = @"collectCell";
static CGFloat const HorizontalCollectionH = 300;
static CGFloat const HorizontalCollectionY = 66;

static CGFloat const VerticalCollectionY = HorizontalCollectionY + HorizontalCollectionH + 44;
static CGFloat const VerticalCollectionH = 300;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setNav];
    [self setHorizontalCollection];
    [self setVerticalCollection];
    [self addChangeButton];

    self.automaticallyAdjustsScrollViewInsets = NO;
   
}
- (void)addChangeButton
{

    UIButton *button = [[UIButton alloc] init];
    button.size = CGSizeMake(44, 30);
    

/**
 *  设置collection垂直
 */
- (void)setVerticalCollection
{
    BBBVerticalLayout *layout = [[BBBVerticalLayout alloc] init];
    CGRect frame = CGRectMake(0, VerticalCollectionY, kScreenW, VerticalCollectionH);
    UICollectionView *vCollect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [vCollect setDataSource:self];
    [vCollect setDelegate:self];
    [vCollect setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:vCollect];
    [vCollect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cvCell];
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
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cvCell];
    [collect registerNib:[UINib nibWithNibName:@"BBBCustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:cvCell];
    [self.view addSubview:collect];
    self.collecionView = collect;
    
}

- (void)setNav
{
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
}

- (void)leftButtonClick {
    
    NSLog(@"-----------------------");
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBBCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvCell forIndexPath:indexPath];
    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
    return  cell;

}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


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
