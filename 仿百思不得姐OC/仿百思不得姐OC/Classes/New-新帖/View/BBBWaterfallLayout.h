//
//  BBBWaterfallLayout.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/6/22.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBBWaterfallLayout;

@protocol BBBWaterfallLayoutDelegate <NSObject>
@required
/**
 *  设置item的高度
 */
- (CGFloat)waterfallLayout:(BBBWaterfallLayout *)waterfallLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;
@optional
/**  设置列数  */
- (NSUInteger)columnCountInWaterfallLayout:(BBBWaterfallLayout *)waterfallLayout;
/**  设置列间距  */
- (CGFloat)columnMarginInWaterfallLayout:(BBBWaterfallLayout *)waterfallLayout;
/**  设置行间距  */
- (CGFloat)rowMarginInWaterfallLayout:(BBBWaterfallLayout *)waterfallLayout;
/**  设置内边距  */
- (UIEdgeInsets)edgeInsetsInWaterfallLayout:(BBBWaterfallLayout *)waterfallLayout;
@end


@interface BBBWaterfallLayout : UICollectionViewLayout

/**
 *  代理
 */
@property (weak, nonatomic) id<BBBWaterfallLayoutDelegate> delegate;

@end
