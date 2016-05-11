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

@interface BSMeViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (weak, nonatomic) UIView *footerView;
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
        
        NSLog(@"---%@---",responseObject);
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
        
        NSURL *url = [NSURL URLWithString:model.icon];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[[NSOperationQueue alloc] init]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:<#(NSURLRequestCachePolicy)#> timeoutInterval:<#(NSTimeInterval)#>]
        NSURLSessionTask *task =
        
        [button setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(footerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:button];
    }
    [self.footerView setFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, self.dataArray.count / column * buttonH)];

}

- (void)footerButtonClick:(UIButton *)button {

    //创建下载图片的url
    NSURL *url = [NSURL URLWithString:urlString];
    
    //创建网络请求配置类
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue new]];
    
    //创建请求并设置缓存策略以及超时时长
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:30.f];
    //*也可通过configuration.requestCachePolicy 设置缓存策略
    
    //创建一个下载任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //下载完成后获取数据 此时已经自动缓存到本地，下次会直接从本地缓存获取，不再进行网络请求
        NSData * data = [NSData dataWithContentsOfURL:location];
        
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //设置图片
            self.image = [UIImage imageWithData:data];
        });
        
        
    }];
    
    
    //启动下载任务
    [task resume];
    
}


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
