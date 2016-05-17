//
//  LBTableFooterView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/14.
//  Copyright © 2016年 LinBin. All rights reserved.
//  自定义footerview   添加button

#import "LBTableFooterView.h"
#import "BSMeDataModel.h"
#import "UIView+LBFrameExtension.h"
#import "LBSquareButton.h"
#import "BSMeWebVViewController.h"
#import <AFNetworking.h>
#import <UIButton+WebCache.h>

@interface LBTableFooterView ()




@end

@implementation LBTableFooterView



- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

//请求数据
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

            [self addButton:arrayM];
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---%@---",error);
            
        }];
        
    }
    return self;
}


/**
 *  添加Button
 */
- (void)addButton:(NSArray *)array {
//最大列数
    NSInteger column = 4;
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / column;
    CGFloat buttonH = buttonW;
    for (NSInteger i = 0; i < array.count; i++) {
        LBSquareButton *button = [[LBSquareButton alloc] init];
        CGFloat buttonX = i % column * buttonW;
        CGFloat buttonY = i / column * buttonH;
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW - 1, buttonH - 1)];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.model = array[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
       
    }
//获取最大行数、最大高度
    NSInteger row = (array.count + column - 1) / column;
    self.height = row * buttonH;
//设置tableview 可滚动范围
    [(UITableView *)self.superview setContentSize:CGSizeMake(0,CGRectGetMaxY(self.frame))];
    

}

/**
 *  button点击方法
 */
- (void)buttonClick:(LBSquareButton *)button {
     
    if ([button.model.url hasPrefix:@"http"]) {
        
        BSMeWebVViewController *webVC = [[BSMeWebVViewController alloc] init];
        webVC.url = button.model.url;
        webVC.name = button.model.name;
  
        UITabBarController *tabBar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBar.selectedViewController;
        [nav pushViewController:webVC animated:YES];
   
        
    }

}














@end
