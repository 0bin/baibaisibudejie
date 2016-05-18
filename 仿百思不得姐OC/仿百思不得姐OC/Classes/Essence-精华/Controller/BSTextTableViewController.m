//
//  BSTextTableViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/18.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSTextTableViewController.h"
#import "BSTextDataModel.h"

#import <YYModel.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>



@interface BSTextTableViewController ()

/** 数据 */
@property (strong, nonatomic) NSMutableArray *textData;
/** 加载更多参数 */
@property (copy,nonatomic) NSString *maxtime;
/** 加载页数 */
@property (assign, nonatomic) NSInteger page;
/** 加载页数 */
@property (assign, nonatomic) NSDictionary *parameters;


@end

@implementation BSTextTableViewController


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
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTextData:)];

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
    parameters[@"type"] = @"29";
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
    parameters[@"type"] = @"29";
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.textData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    BSTextDataModel *model = self.textData[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
