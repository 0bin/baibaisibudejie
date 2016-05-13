//
//  BSMeViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSMeViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import <AFNetworking.h>
#import "BSMeDataModel.h"
#import <UIButton+WebCache.h>

@interface BSMeViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) UIView *footerView;
@property (strong, nonatomic) NSMutableDictionary *images;
@property (strong, nonatomic) NSMutableDictionary *operationsDict;
@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNavigationItem];
    [self setTable];
    
    UIView *footerView = [[UIView alloc] init];
    [footerView setBackgroundColor:[UIColor redColor]];
    self.tableView.tableFooterView = footerView;
    self.footerView = footerView;

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        

        NSMutableArray *arrayM = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"square_list"]) {
            BSMeDataModel *model = [BSMeDataModel modelWihtDict:dict];
            [arrayM addObject:model];
        }
        self.dataArray = arrayM;
        [self addFooterView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@---",error);
        
    }];
}

- (void)addFooterView {

    NSInteger column = 4;
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / column;
    CGFloat buttonH = buttonW;

    
    for (NSInteger i = 0; i < self.dataArray.count; i++) {
        
        CGFloat buttonX = i % column * buttonW;
        CGFloat buttonY = i / column * buttonH;
        BSMeDataModel *model = self.dataArray[i];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        NSLog(@"---%@---",model.icon);
        [button sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(footerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:button];
    }
    [self.footerView setFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, self.dataArray.count / column * buttonH)];

}



- (void)footerButtonClick:(UIButton *)button {




}


/**
 *  设置TableView
 */
- (void)setTable {

    [self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    [self.tableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
}

/**
 *  设置导航栏
 */
- (void)setNavigationItem {
    
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *nightMode = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    [self.navigationItem setRightBarButtonItems:@[setting,nightMode]];

}

- (void)settingClick {
    
    NSLog(@"-----------------------");
}
- (void)nightModeClick {
    
    NSLog(@"-----------------------");
}


#pragma mark <TableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"meCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"meCell"];
    }
    
    if (indexPath.section == 0) {
       cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
       cell.textLabel.text = @"登陆注册";
        
        UIImage *icon = [UIImage imageNamed:@"defaultUserIcon"];
        CGSize itemSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    } else if(indexPath.section == 1) {
    cell.textLabel.text = @"离线下载";
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
