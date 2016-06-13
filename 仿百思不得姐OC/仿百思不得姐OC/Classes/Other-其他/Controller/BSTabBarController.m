//
//  BSTabBarController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/29.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSAttentionViewController.h"
#import "BSNewViewController.h"
#import "BSEssenceViewController.h"
#import "BSMeViewController.h"
#import "BSTabBar.h"
#import "BSNavigationController.h"
#import "BSConst.h"


@interface BSTabBarController ()

@end

@implementation BSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBarItemAppearance];
    
    BSEssenceViewController *essence = [[BSEssenceViewController alloc] init];
    [self addTabBarChildVC:essence Image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    BSNewViewController *new = [[BSNewViewController alloc] init];
    [self addTabBarChildVC:new Image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon" title:@"新帖"];
    
    BSAttentionViewController *attention = [[BSAttentionViewController alloc] init];
    [self addTabBarChildVC:attention Image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon" title:@"关注"];
 
    BSMeViewController *me = [[BSMeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addTabBarChildVC:me Image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon" title:@"我"];
    //通过kvc替换系统tabbar
    BSTabBar *tabBar = [[BSTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    

}

/**
 *  添加tabbar子控制器
 *
 *  @param childVC       传入控制器
 *  @param image         图片
 *  @param selectedImage 选中图片
 *  @param title         标题
 */
- (void)addTabBarChildVC:(UIViewController *)childVC Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.title = title;
    BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];

}

/**
 *  统一设置TabBarItem文字样式
 */
- (void)setTabBarItemAppearance {
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



@end
