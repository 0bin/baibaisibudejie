//
//  BSMeViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <Social/Social.h>

#import <SVProgressHUD.h>
#import "BSMeViewController.h"
#import "UIBarButtonItem+LBButtonToBarButtonItem.h"
#import "BSMeDataModel.h"
#import "LBVerticalButton.h"
#import "LBTableFooterView.h"
#import "UIView+LBFrameExtension.h"
#import "BSLoginViewController.h"


@interface BSMeViewController ()
@property (strong, nonatomic) NSArray *dataArray;

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
    
    LBTableFooterView *footerView = [[LBTableFooterView alloc] init];
    self.tableView.tableFooterView = footerView;
    [self.tableView layoutIfNeeded];
    [self.tableView setContentSize:CGSizeMake(0, CGRectGetMaxY(footerView.subviews.lastObject.frame))];
    [self.tableView reloadData];
    


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
    return 3;
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
    } else if(indexPath.section == 2) {
        cell.textLabel.text = @"分享";
    }
    
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        BSLoginViewController *login = [[BSLoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    } else if (indexPath.section == 1) {
//        [UMSocialData defaultData].extConfig.title = @"分享的title";
//        [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
//        [UMSocialSnsService presentSnsIconSheetView:self
//                                             appKey:@"507fcab25270157b37000010"
//                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                         shareImage:[UIImage imageNamed:@"icon"]
//                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
//                                           delegate:self];
    
    }else if (indexPath.section == 2) {
        // 1.判断平台是否可用
        if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
            [SVProgressHUD showErrorWithStatus:@"在设置内配置账号"];
            [SVProgressHUD dismiss];
            return;
        }

        SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [composeVc setInitialText:@"share"];
        // 2.2.添加一个图片
        [composeVc addImage:[UIImage imageNamed:@""]];
        
        // 2.3.添加一个分享的链接
        [composeVc addURL:[NSURL URLWithString:@""]];
        
        // 3.弹出分享控制器
        [self presentViewController:composeVc animated:YES completion:nil];
        
        // 4.监听用户点击了取消还是发送
        composeVc.completionHandler = ^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"点击了取消");
            } else {
                NSLog(@"点击了发送");
            }
        };
    }
    
    

}

@end
