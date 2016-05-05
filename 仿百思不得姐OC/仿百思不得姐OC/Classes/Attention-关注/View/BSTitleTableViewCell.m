//
//  BSTitleTableViewCell.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/4.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "BSTitleTableViewCell.h"

@interface BSTitleTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *indicator;



@end

@implementation BSTitleTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"bcell";
    BSTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BSTitleTableViewCell" owner:nil options:nil].lastObject;
    }
    return cell;
}


- (void)setCategoryModel:(BSCategoryModel *)CategoryModel {
    _CategoryModel = CategoryModel;
    self.textLabel.text = CategoryModel.name;

    

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor lightGrayColor];
    self.textLabel.textColor = [UIColor blackColor];
    [self.textLabel setHighlightedTextColor:[UIColor redColor]];
    self.layoutMargins = UIEdgeInsetsZero;
    self.separatorInset = UIEdgeInsetsZero;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.indicator.hidden = !selected;
    self.textLabel.textColor = selected ? [UIColor redColor] : [UIColor blackColor];
    // Configure the view for the selected state
}

@end
