//
//  BSTextDataModel.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/18.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import "NSDate+LBDate.h"
#import "BSTextDataModel.h"
#import "BSCommentModel.h"


@implementation BSTextDataModel
{
    CGFloat _cellHeight;
    
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"ID" : @"id"
             };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"top_cmt" : @"BSCommentModel"
             };
}

- (CGFloat )cellHeight {

    if (!_cellHeight) {
        
        CGSize maxsize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        CGFloat contentLabelH = [self.text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        CGFloat iconH = 35;
        CGFloat bottomViewH = 44;
        CGFloat marign = 8;
        //文字内容高度
        _cellHeight = iconH + contentLabelH + marign * 2 + 20;
       //图片高度
        if ( (self.type == BSBasicTypePicture) && (self.width != 0) ) {
            
            CGFloat pictureW = maxsize.width;
            CGFloat pictureH = pictureW * self.height / self.width ;
            if (pictureH > 1000) {
                self.longPicture = YES;
                pictureH = 250;
            }
            CGFloat pictureX = marign;
            CGFloat pictureY = _cellHeight + marign;
            _pictureFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + 2 * marign;


        } else if ((self.type == BSBasicTypeVoice)&& (self.width != 0)) {
        
            CGFloat voiceX = marign;
            CGFloat voiceY = iconH + contentLabelH + marign * 2 + 20;
            CGFloat voiceW = maxsize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + 2 * marign;
        
        } else if ((self.type == BSBasicTypeVedio)&& (self.width != 0)) {
            CGFloat vedioX = marign;
            CGFloat vedioY = iconH + contentLabelH + marign * 2 + 20;
            CGFloat vedioW = maxsize.width;
            CGFloat vedioH = vedioW * self.height / self.width;
            _vedioFrame = CGRectMake(vedioX, vedioY, vedioW, vedioH);
            _cellHeight += vedioH + 2 * marign;
        
        }
        BSCommentModel *comment = self.top_cmt.firstObject;
        if (comment) {
            NSString *content = [NSString stringWithFormat:@"%@:%@", comment.user.username,comment.content];
            CGFloat contentH = [content boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
            _cellHeight += contentH + marign * 4;
        }
        //底部工具条
        _cellHeight += bottomViewH + marign;
    }
    return _cellHeight;
}

/**
 *  处理时间显示样式
 */

- (NSString *)created_at {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *creatDate = [formatter dateFromString:_created_at];
    if (creatDate.isThisYear) {//今年
        
        if (creatDate.isToday) {//今天
            NSDateComponents *components = [[NSDate date] dateIntervalWithFromDate:creatDate];
            if (components.hour >= 1) {//大于一小时
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            } else if (components.minute >= 1) {    //大于一分 少于一小时
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            } else {  //小于一分钟
                return @"刚刚";
            }
            
        } else if (creatDate.isYesterday){//昨天
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:creatDate];
        } else {//非今天昨天
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return  [formatter stringFromDate:creatDate];
        }
        
    } else {//非今年
        
        return  _created_at;
    }

}
@end
