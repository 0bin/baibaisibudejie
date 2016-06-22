//
//  BSWaterfallController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSWaterfallController.h"
#import "BBBWaterfallLayout.h"
#import "BBBImageModel.h"
#import "BBBCustomCollectionCell.h"




/**
 *  cell复用名
 */
static NSString *const collectionCell = @"collectionCell";


@interface BSWaterfallController ()
/**
 *  collectionView
 */
@property (weak, nonatomic) UICollectionView *collectionView;
/**
 *  图片模型
 */
@property (strong, nonatomic) NSMutableArray *imageData;


@end

@implementation BSWaterfallController



//- (NSMutableArray *)imageData
//{
//    if (_imageData == nil) {
//        _imageData = [NSMutableArray array];
//    }
//    return _imageData;
//}
//
//
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];



    
}
//
//
//
///**
// *  流水布局
// */
//- (void)setWaterfallCollection
//{
//    BBBWaterfallLayout *layout = [[BBBWaterfallLayout alloc] init];
//    
//    CGRect frame = self.view.frame;
//    
//    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
//    
//    [collect setDataSource:self];
////    [Collect setDelegate:self];
//    [collect registerNib:[UINib nibWithNibName:@"BBBCustomCollectionCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
//    [collect setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:collect];
//    self.collectionView = collect;
//
//    
//}
//
//#pragma mark - UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 20;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    BBBCustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
//    cell.imageName = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
//    return  cell;
//    
//}






@end
