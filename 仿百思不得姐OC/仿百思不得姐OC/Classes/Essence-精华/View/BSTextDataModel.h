//
//  BSTextDataModel.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/18.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSConst.h"



@interface BSTextDataModel : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;

/** 文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;

/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;

/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;

/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;

/** 评论的数量 */
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;

/** 图片的高度 */
@property (nonatomic, assign)  BSBasicType type;

/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;

/** 图片小 */
@property (nonatomic, copy) NSString *image0;
/** 图片大 */
@property (nonatomic, copy) NSString *image1;
/** 图片中 */
@property (nonatomic, copy) NSString *image2;

/**
 *  cell的高度
 */
@property (assign, nonatomic,readonly) CGFloat cellHeight;

/** picture frame */
@property (assign, nonatomic,readonly) CGRect pictureFrame;

/** 图片是否太长 */
@property (assign, nonatomic,getter=isLongPicture) BOOL longPicture;

/** progress加载进度 */
@property (assign, nonatomic) CGFloat progressFloat;

@end
