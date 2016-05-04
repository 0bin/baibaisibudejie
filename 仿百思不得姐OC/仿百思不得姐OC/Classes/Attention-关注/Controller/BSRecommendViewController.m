//
//  BSRecommendViewController.m
//  仿-百思不得姐
//
//  Created by LinBin on 16/4/30.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSRecommendViewController.h"
#import <AFNetworking.h>

#import "BSCategoryModel.h"


@interface BSRecommendViewController () 
@property (strong, nonatomic) NSArray *category;
@end

@implementation BSRecommendViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
  
    
    NSMutableDictionary *patameters = [NSMutableDictionary dictionary];
    patameters[@"a"] = @"category";
    patameters[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:patameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"---%@---",responseObject);
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        


        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}



#pragma mark <TableView DataSource>
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//    
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//}




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
