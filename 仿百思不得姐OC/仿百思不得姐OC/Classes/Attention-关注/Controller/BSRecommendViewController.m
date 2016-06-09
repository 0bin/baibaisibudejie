//
//  BSRecommendViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//


#import <AFNetworking.h>

#import "BSRecommendViewController.h"
#import "BSCategoryModel.h"
#import "BSTitleTableViewCell.h"

@interface BSRecommendViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *titleTable;
@property (weak, nonatomic) IBOutlet UITableView *contentLabel;

@property (strong, nonatomic) NSArray *category;
@end

@implementation BSRecommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self loadTitleTableData];
    [self.titleTable setTableFooterView:[[UIView alloc] init]];


    

}

/**
 *  请求左侧分类数据
 */
- (void)loadTitleTableData {

    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"category";
    patameters[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //取出数据转成模型
        NSArray *array = responseObject[@"list"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            BSCategoryModel *model = [BSCategoryModel modelWithDict:dict];
            [arrayM addObject:model];
        }
        self.category = arrayM;
        [self.titleTable reloadData];
        /** 设置table默认点击第一行 */
        [self.titleTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




#pragma mark <TableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.category.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    BSTitleTableViewCell *cell = [BSTitleTableViewCell cellWithTableView:tableView];
    cell.CategoryModel = self.category[indexPath.row];
    return cell;
}

#pragma mark <TableView Delegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BSCategoryModel *model = self.category[indexPath.row];
 
    
    /**
     *  请求右侧内容数据
     */
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"list";
    patameters[@"c"] = @"subscribe";
    patameters[@"categoryzz_id"] = @(model.id);
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---%@---",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@---",error);
        
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
