//
//  BSCommentModel.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/31.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSUserModel;
@interface BSCommentModel : NSObject

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) BSUserModel *user;

@end
