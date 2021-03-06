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

@property (strong, nonatomic) NSArray *hotComment;
@property (strong, nonatomic) NSMutableArray *recentComment;
@property (assign, nonatomic) NSInteger page;
/**
 *  <#Description#>
 */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation BSCommentViewController
/**
 *  懒加载网络请求manager
 */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc]init];
    }
    return _manager;
}

- (NSArray *)hotComment {
    if (_hotComment == nil) {
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

/**
 *  设置上啦下拉刷新
 */
- (void)setRefresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCommentData)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComentData)];
}


/**
 *  加载更多数据
 */
- (void)loadMoreComentData {
    //取消manager内的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page;
    //请求数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.model.ID;
    parameters[@"page"] = @(page);
    BSCommentModel *comment = self.recentComment.lastObject;
    parameters[@"lasticd"] = comment.ID;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *new = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"]) {
            BSCommentModel *model = [BSCommentModel yy_modelWithJSON:dict];
            [new addObject:model];
        }
        NSArray *newarray = new;
        [self.recentComment addObjectsFromArray:newarray];
        
        self.page = page;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.recentComment.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer setHidden:YES];
        
    }];



}

/**
 *  加载数据
 */
- (void)loadCommentData {
    //取消manager内的所有任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //请求数据
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.model.ID;
    parameters[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
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
//下拉刷新要回到第一页
        self.page = 1;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger moreCommentCount = [responseObject[@"total"] integerValue];
        if (self.recentComment.count > moreCommentCount) {
            self.tableView.mj_footer.hidden = YES;
        }
        
        
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
    //取消session内所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
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

#pragma make <tableView delegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    } else {
        BSCommentTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect rect = CGRectMake(cell.x, cell.height * 0.5, cell.width , cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"ding" action:@selector(ding:)];
        UIMenuItem *cai = [[UIMenuItem alloc] initWithTitle:@"cai " action:@selector(cai :)];
        UIMenuItem *jubao = [[UIMenuItem alloc] initWithTitle:@"jubao" action:@selector(jubao:)];
        menu.menuItems = @[ding,cai,jubao];
    }
}

- (void)ding:(UIMenuController *)menu
{
    NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
    NSLog(@"---%@---",indexpath);
      NSLog(@"%s",__func__);
}
- (void)cai :(UIMenuController *)menu
{
    NSLog(@"%s",__func__);
}
- (void)jubao:(UIMenuController *)menu
{
    NSLog(@"%s",__func__);
}
@end
