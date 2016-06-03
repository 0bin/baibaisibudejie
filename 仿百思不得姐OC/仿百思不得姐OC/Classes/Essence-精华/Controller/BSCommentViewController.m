//
//  BSCommentViewController.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/1.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSCommentViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "BSTextTableViewCell.h"
#import "BSTextDataModel.h"
#import "UIView+LBFrameExtension.h"
#import "BSCommentModel.h"
#import "BSCommentTableViewCell.h"

#import <MJRefresh.h>
#import <AFNetworking.h>
#import <YYModel.h>

@interface BSCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomLine;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  <#Description#>
 */
@property (strong, nonatomic) NSArray *hotComment;
@property (strong, nonatomic) NSMutableArray *recentComment;
@end

@implementation BSCommentViewController

- (NSArray *)hotComment {
    if (_hotComment == nil) {
     NSLog(@"-----------------------");
        _hotComment = [NSArray array];
        }
    
    return _hotComment;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self setNav];
    [self setHeardView];
    [self setRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BSCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
    [self.tableView setEstimatedRowHeight:44];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
   
}

- (void)setRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommentData)];
    [self.tableView.mj_header beginRefreshing];
}
                                
- (void)loadCommentData {
    //请求更多数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.model.ID;
    parameters[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *hotarray = [NSMutableArray array];
        NSMutableArray *recentarray = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject[@"hot"]) {
            BSCommentModel *model = [BSCommentModel yy_modelWithJSON:dict];
            [hotarray addObject:model];
        }
        for (NSDictionary *dict in responseObject[@"data"]) {
            BSCommentModel *model = [BSCommentModel yy_modelWithJSON:dict];
            [recentarray addObject:model];
        }
        self.hotComment = hotarray;
        self.recentComment = recentarray;
            NSLog(@"%@",self.hotComment);
        
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
                                
}
- (void)keyboardChangeFrame:(NSNotification *)notification {
    
    CGRect KBFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.toolBarBottomLine.constant = [UIScreen mainScreen].bounds.size.height - KBFrame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];

}

/**
 *  移除通知
 */
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/**
 *  设置导航栏
 */
- (void)setHeardView {
    
    UIView *heardView = [[UIView alloc] init];
    BSTextTableViewCell *cell = [BSTextTableViewCell cell];
    cell.textData = self.model;
    cell.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.model.cellHeight);
    heardView.height = self.model.cellHeight + 50;
    [heardView addSubview:cell];
    self.tableView.tableHeaderView = heardView;
}
/**
 *  设置导航栏
 */
- (void)setNav{
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(moreInfoButtonClick)]];
}
- (void)moreInfoButtonClick {
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
}

#pragma mark <TableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotComment.count)return 2;
    
    if (self.recentComment.count)return 1;

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComment.count ? self.hotComment.count : self.recentComment.count;
    }
    if (section == 1) {
        return self.recentComment.count;
    }
    return 0;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.hotComment.count ? @"最火评论" : @"最新评论";
    }
    return @"最新评论";
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    BSCommentModel *model = [self commentInSection:indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
    
}

- (NSArray *)commentInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComment.count ? self.hotComment : self.recentComment;
    }
    return self.recentComment;
}


@end
