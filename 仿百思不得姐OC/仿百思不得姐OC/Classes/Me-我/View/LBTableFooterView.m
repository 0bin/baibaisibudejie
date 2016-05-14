//
//  LBTableFooterView.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/14.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "LBTableFooterView.h"
#import "BSMeDataModel.h"
#import "UIView+LBFrameExtension.h"
#import <AFNetworking.h>
#import <UIButton+WebCache.h>

@interface LBTableFooterView ()




@end

@implementation LBTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];        
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

- (void)addButton:(NSArray *)array {
    
    NSInteger column = 4;
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width / column;
    CGFloat buttonH = buttonW;
    
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIButton *button = [[UIButton alloc] init];
        CGFloat buttonX = i % column * buttonW;
        CGFloat buttonY = i / column * buttonH;
        BSMeDataModel *model = array[i];
        [button setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
        [button setTitle:model.name forState:UIControlStateNormal];
        [self addSubview:button];
       
    }
    self.height = 

}

















@end
