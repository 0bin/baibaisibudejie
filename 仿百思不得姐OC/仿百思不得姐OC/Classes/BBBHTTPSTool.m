//
//  BBBHTTPSTool.m
//  项目集合
//
//  Created by LinBin on 16/6/24.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BBBHTTPSTool.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface BBBHTTPSTool ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation BBBHTTPSTool


static id _tool;
/**  单例重写allocWithZone  */
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool= [super allocWithZone:zone];
    });
    return _tool;
}
/**  单例  */
+ (instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[self alloc] init];
    });
    return _tool;
}
/**  单例重写copyWithZone  */
- (id)copyWithZone:(NSZone *)zone
{
    return _tool;
}




- (AFHTTPSessionManager *)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (_manager == nil) {
            _manager = [AFHTTPSessionManager manager];
        }
        
    });
    
    return _manager;
}


- (void)GET:(NSString *)URL parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure;
{
    [SVProgressHUD show];
    
    [self.manager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        succeed(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (void)Post:(NSString *)URL parameters:(id)parameters succeed:(void (^)(id responseObject))succeed failure:(void (^)(NSError *error))failure
{
    [SVProgressHUD show];
    
    [self.manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        succeed(responseObject);
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

@end
