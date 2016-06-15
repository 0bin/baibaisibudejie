//
//  BSNewViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSNewViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "BBBLabel.h"
#import "BBBScrollLayout.h"

@interface BSNewViewController () <UICollectionViewDataSource>

@end

@implementation BSNewViewController
static NSString *const cvCell = @"collectCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(leftButtonClick)];
    [self.navigationItem setLeftBarButtonItem:item];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
   
    BBBScrollLayout *layout = [[BBBScrollLayout alloc] init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.8, 200);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect frame = CGRectMake(0, 88, self.view.frame.size.width, 200);
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    [collect setDataSource:self];
    [collect setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:collect];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cvCell];
 
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    

    
    
}



- (void)leftButtonClick {
    
    NSLog(@"-----------------------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 55;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return  cell;

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
