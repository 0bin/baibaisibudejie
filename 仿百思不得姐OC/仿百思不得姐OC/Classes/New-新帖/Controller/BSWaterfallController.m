//
//  BSWaterfallController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSWaterfallController.h"
#import "BSWaterfallLayout.h"
#import "BSCollectionWaterfallCell.h"
#import "BBBImageModel.h"

#import <MJRefresh.h>
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <YYModel.h>


/**
 *  cell复用名
 */
static NSString *const collectionCell = @"collectionCell";


@interface BSWaterfallController ()<UICollectionViewDataSource>
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

- (NSMutableArray *)imageData
{
    if (_imageData == nil) {
        _imageData = [NSMutableArray array];
    }
    return _imageData;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setWaterfallCollection];
    [self addRefreshController];
    
}

/**
 *  添加刷新控件
 */
- (void)addRefreshController {
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadImageData:)];
//    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreImageData:)];
    
}

/**
 *  请求数据
 */
- (void)loadImageData:(UIRefreshControl *)refresh {
    
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    
    [self.collectionView.mj_footer endRefreshing];
    //请求数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSInteger pn = 0;
    NSString *tag1 = @"美女";
    NSString *tag2 = @"小清新";
    parameters[@"pn"] = [NSString stringWithFormat:@"%ld",(long)pn];
    parameters[@"rn"] = @60;
    
    
    NSString *urlstr = [NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",tag1,tag2];
    NSString *url = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSLog(@"---%@---",url);
   
    
    [[AFHTTPSessionManager manager]GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/linbin/Desktop/xxoooo.plist" atomically:YES];
        
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"imgs"]) {
            BBBImageModel *model = [BBBImageModel yy_modelWithJSON:dict];
            [arrayM addObject:model];
        }
        self.imageData = arrayM;
        //更新table数据
        [self.collectionView reloadData];
        //结束刷新
        [self.collectionView.mj_header endRefreshing];
   
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
    
}

///**
// *  请求更多数据
// */
//- (void)loadMoreImageData:(UIRefreshControl *)refresh {
//    
//    [self.tableView.mj_header endRefreshing];
//    self.page++;
//    //请求更多数据
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    
//    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        if (self.parameters != parameters) return;
//        
//        self.maxtime = responseObject[@"info"][@"maxtime"];
//        NSMutableArray *arrayM = [NSMutableArray array];
//        for (NSDictionary *dict in responseObject[@"list"]) {
//            BSTextDataModel *model = [BSTextDataModel yy_modelWithJSON:dict];
//            [arrayM addObject:model];
//        }
//        //添加更多数据
//        [self.textData addObjectsFromArray:arrayM];
//        //更新table 数据
//        [self.tableView reloadData];
//        //结束刷新
//        [self.tableView.mj_footer endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        self.page--;
//        [self.tableView.mj_footer endRefreshing];
//    }];
//    
//}

/**
 *  流水布局
 */
- (void)setWaterfallCollection
{
    BSWaterfallLayout *layout = [[BSWaterfallLayout alloc] init];
    
    CGRect frame = self.view.frame;
    
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    [collect setDataSource:self];
//    [Collect setDelegate:self];
    [collect setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:collect];
    self.collectionView = collect;
    [collect registerNib:[UINib nibWithNibName:@"BSCollectionWaterfallCell" bundle:nil] forCellWithReuseIdentifier:collectionCell];
    
  
}
#pragma - make -- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    BSCollectionWaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}






@end
