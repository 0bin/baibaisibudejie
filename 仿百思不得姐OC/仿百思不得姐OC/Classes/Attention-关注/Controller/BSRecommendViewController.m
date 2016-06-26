//
//  BSRecommendViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//



#import <YYModel.h>
#import "BSRecommendViewController.h"
#import "BSCategoryModel.h"
#import "BSTitleTableViewCell.h"
#import "BBBHTTPSTool.h"
#import "BSAttentionUserModel.h"
#import "BSAttentionContentCell.h"


@interface BSRecommendViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *titleTable;

@property (weak, nonatomic) IBOutlet UITableView *contentTable;
/**
 *  分类数据
 */
@property (strong, nonatomic) NSArray *categoryData;
/**
 *  用户数据
 */
@property (strong, nonatomic) NSArray *useData;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *patameters;
/**
 *  <#Description#>
 */
@property (strong, nonatomic) BBBHTTPSTool *tool;

@end



@implementation BSRecommendViewController

static NSString *const contentCell = @"contentCell";
static NSString *const titleCell = @"titleCell";

- (NSArray *)categoryData
{
    if (!_categoryData) {
        _categoryData = [[NSArray alloc]init];
    }
    return _categoryData;
}


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
    [self loadTitleTableData];
    
    [self.titleTable setTableFooterView:[[UIView alloc] init]];
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    [self.titleTable setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self.contentTable setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self.contentTable registerNib:[UINib nibWithNibName:@"BSAttentionContentCell" bundle:nil] forCellReuseIdentifier:contentCell];
    [self.titleTable registerNib:[UINib nibWithNibName:@"BSTitleTableViewCell" bundle:nil] forCellReuseIdentifier:titleCell];
    self.contentTable.rowHeight = 88;

  

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
            BSCategoryModel *model = [BSCategoryModel modelWithDict:dict];
            [arrayM addObject:model];
        }
        self.categoryData = arrayM;
        [self.titleTable reloadData];
        /** 设置table默认点击第一行 */
        [self.titleTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

    } failure:^(NSError *error) {
        
    }];


     
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
        return self.useData.count;
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.titleTable) {
        
        BSTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell ];
        cell.CategoryModel = self.categoryData[indexPath.row];
        return cell;

    } else {
    
        BSAttentionContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCell];
        cell.model = self.useData[indexPath.row];
        return cell;
    }
 

}

#pragma mark <TableView Delegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BSCategoryModel *model = self.categoryData[indexPath.row];
    
    /**
     *  请求右侧内容数据
     */
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"list";
    patameters[@"c"] = @"subscribe";
    patameters[@"category_id"] = @(model.id);
    patameters[@"page"] = @1;
    self.patameters = patameters;
    
    [self.tool GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters succeed:^(id responseObject) {
        NSMutableArray *arrayUser = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"list"])
        {
            BSAttentionUserModel *model = [BSAttentionUserModel yy_modelWithDictionary:dict];
            [arrayUser addObject:model];
        }
        self.useData = arrayUser;
        [self.contentTable reloadData];
        
    } failure:^(NSError *error) {
   
    }];
  
}






@end
