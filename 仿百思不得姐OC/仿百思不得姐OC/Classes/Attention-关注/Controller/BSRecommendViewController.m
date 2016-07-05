//
//  BSRecommendViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//



#import <YYModel.h>
#import <MJRefresh.h>
#import "BSRecommendViewController.h"
#import "BSCategoryModel.h"
#import "BSTitleTableViewCell.h"
#import "BBBHTTPSTool.h"
#import "BSAttentionUserModel.h"
#import "BSAttentionContentCell.h"

#define BBBSelectedCategory self.categoryData[self.titleTable.indexPathForSelectedRow.row]
@interface BSRecommendViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *titleTable;

@property (weak, nonatomic) IBOutlet UITableView *contentTable;
/**  分类数据*/
@property (strong, nonatomic) NSArray *categoryData;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *patameters;

@property (strong, nonatomic) BBBHTTPSTool *tool;

@end



@implementation BSRecommendViewController

static NSString *const contentCell = @"contentCell";
static NSString *const titleCell = @"titleCell";






- (BBBHTTPSTool *)tool
{
    if (_tool == nil) {
        _tool = [BBBHTTPSTool shareTool];
    }
    return _tool;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self categoryData];
    [self loadTitleTableData];
    
    [self BBBsetTableView];

    [self setRefresh];

        [self loadTitleTableData];
    
  

}
- (void)checkFooter
{
    
    
}
- (void)setRefresh
{
    self.contentTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUserData)];
    
    self.contentTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUserData)];
    
}

- (void)loadNewUserData
{
    BSCategoryModel *model = self.categoryData[self.titleTable.indexPathForSelectedRow.row];
    /**
     *  请求右侧内容数据
     */
    model.currentPage = 1;
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"list";
    patameters[@"c"] = @"subscribe";
    patameters[@"category_id"] = @(model.id);
    patameters[@"page"] = @(model.currentPage);
    self.patameters = patameters;
    
    [self.tool GET:@"https://api.budejie.com/api/api_open.php"
               parameters:patameters
               succeed:^(id responseObject)
               {
                   NSMutableArray *arrayUser = [NSMutableArray array];
                   for (NSDictionary *dict in responseObject[@"list"])
                   {
                       BSAttentionUserModel *model = [BSAttentionUserModel yy_modelWithDictionary:dict];
                       [arrayUser addObject:model];
                   }
                   
                   [model.allUserData addObjectsFromArray:arrayUser];
                   [self.contentTable reloadData];
                   [self.contentTable.mj_header endRefreshing];
               
               }
               failure:^(NSError *error) {
               
     }];

}

- (void)loadMoreUserData
{
    BSCategoryModel *model = self.categoryData[self.titleTable.indexPathForSelectedRow.row];
    /**
     *  请求右侧内容数据
     */
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"list";
    patameters[@"c"] = @"subscribe";
    patameters[@"category_id"] = @(model.id);
    patameters[@"page"] = @(++model.currentPage);
    self.patameters = patameters;
    
    [self.tool GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters succeed:^(id responseObject) {
        
        NSMutableArray *arrayUser = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"])
        {
            BSAttentionUserModel *model = [BSAttentionUserModel yy_modelWithDictionary:dict];
            [arrayUser addObject:model];
        }
        
        [model.allUserData addObjectsFromArray:arrayUser];
        [self.contentTable reloadData];
        [self.contentTable.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  请求左侧分类数据
 */
- (void)loadTitleTableData {
    
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"category";
    patameters[@"c"] = @"subscribe";
    
    [self.tool GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters succeed:^(id responseObject) {
        //取出数据转成模型
        NSArray *array = responseObject[@"list"];
        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            BSCategoryModel *model = [BSCategoryModel yy_modelWithDictionary:dict];
            [arrayM addObject:model];
        }
        self.categoryData = arrayM;
        [self.titleTable reloadData];
        /** 设置table默认点击第一行 */
        [self.titleTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.contentTable.mj_header beginRefreshing];
    } failure:^(NSError *error) {
        
    }];
    
}
/**
 *  设置table相关
 */
- (void)BBBsetTableView
{
    self.title = @"关注";
    [self.titleTable setTableFooterView:[[UIView alloc] init]];
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    [self.titleTable setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self.contentTable setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self.contentTable registerNib:[UINib nibWithNibName:@"BSAttentionContentCell" bundle:nil] forCellReuseIdentifier:contentCell];
    [self.titleTable registerNib:[UINib nibWithNibName:@"BSTitleTableViewCell" bundle:nil] forCellReuseIdentifier:titleCell];
    self.contentTable.rowHeight = 88;
}







#pragma mark <TableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.titleTable) {
        return self.categoryData.count;
    } else {
    
        BSCategoryModel *model = BBBSelectedCategory;
        return model.allUserData.count;
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.titleTable) {
        
        BSTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell forIndexPath:indexPath];
        cell.CategoryModel = self.categoryData[indexPath.row];
        return cell;

    } else {
    
        BSAttentionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCell forIndexPath:indexPath];
        BSCategoryModel *model = BBBSelectedCategory;
        cell.model = model.allUserData[indexPath.row];
        return cell;
    }
 

}

#pragma mark <TableView Delegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BSCategoryModel *model = self.categoryData[indexPath.row];
    if (model.allUserData.count) {
        [self.contentTable reloadData];
    } else {
        [self.contentTable reloadData];
        [self.contentTable.mj_header beginRefreshing];
    }

}



- (void)dealloc
{
    [self.tool cancelAllOperations];
}


@end
