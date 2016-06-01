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

@interface BSCommentViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomLine;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *footerView = [[UIView alloc] init];
    BSTextTableViewCell *cell = [BSTextTableViewCell cell];
    cell.textData = self.model;
    cell.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.model.cellHeight);
    
    footerView.height = self.model.cellHeight + 50;
    [footerView addSubview:cell];
    
    self.tableView.tableHeaderView = footerView;
    
    
    
    
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:self action:@selector(moreInfoButtonClick)]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChangeFrame:(NSNotification *)notification {
    CGRect KBFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.toolBarBottomLine.constant = [UIScreen mainScreen].bounds.size.height - KBFrame.origin.y;
    [UIView animateWithDuration:duration animations:^{

        [self.view layoutIfNeeded];
    }];

    


}
- (void)moreInfoButtonClick {



}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];
}

#pragma mark <TableView DataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld", indexPath.row];
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"xxoo";

}
@end
