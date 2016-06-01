//
//  BSBasicTableViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/20.
//  Copyright © 2016年 LinBin. All rights reserved.
//


#import <YYModel.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

#import "BSBasicTableViewController.h"
#import "BSTextDataModel.h"
#import "BSTextTableViewCell.h"
#import "BSCommentViewController.h"


@interface BSBasicTableViewController ()

/** 数据 */
@property (strong, nonatomic) NSMutableArray *textData;
/** 加载更多参数 */
@property (copy,nonatomic) NSString *maxtime;
/** 加载页数 */
@property (assign, nonatomic) NSInteger page;
/** 加载页数 */
@property (assign, nonatomic) NSDictionary *parameters;

@end

@implementation BSBasicTableViewController



- (NSMutableArray *)textData {
    
    if (_textData == nil) {
        _textData = [NSMutableArray array];
    }
    return  _textData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加刷新控件
    [self addRefreshController];
    
}

/**
 *  添加刷新控件
 */
- (void)addRefreshController {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTextData:)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTextData:)];
    
}

/**
 *  请求数据
 */
- (void)loadTextData:(UIRefreshControl *)refresh {
    
    [self.tableView.mj_footer endRefreshing];
    //请求数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"page"] = @(self.page);
    self.parameters = parameters;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         [responseObject writeToFile:@"/Users/linbin/Desktop/xx.plist" atomically:YES];
  
        if (self.parameters != parameters) return;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            BSTextDataModel *model = [BSTextDataModel yy_modelWithJSON:dict];
            [arrayM addObject:model];
        }
        self.textData = arrayM;
        //更新table数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}

/**
 *  请求更多数据
 */
- (void)loadMoreTextData:(UIRefreshControl *)refresh {
    
    [self.tableView.mj_header endRefreshing];
    self.page++;
    //请求更多数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    parameters[@"page"] = @(self.page);
    parameters[@"maxtime"] = self.maxtime;
    self.parameters = parameters;
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.parameters != parameters) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"]) {
            BSTextDataModel *model = [BSTextDataModel yy_modelWithJSON:dict];
            [arrayM addObject:model];
        }
        //添加更多数据
        [self.textData addObjectsFromArray:arrayM];
        //更新table 数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.page--;
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.textData.count == 0);
    return self.textData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"textCell";
    BSTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [BSTextTableViewCell cell];
    }
    
    cell.textData = self.textData[indexPath.row];
    
    return cell;
}

#pragma mark - Tableview datagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTextDataModel *model = self.textData[indexPath.row];
    return model.cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSCommentViewController *commentVC = [[BSCommentViewController alloc] init];
    commentVC.model = self.textData[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    


}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    return 200;
//}


@end
