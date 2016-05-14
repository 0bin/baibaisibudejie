//
//  BSMeViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSMeViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "BSMeDataModel.h"
#import "LBVerticalButton.h"
#import "LBTableFooterView.h"

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
    
    
    self.tableView.tableFooterView = [[LBTableFooterView alloc] init];
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
