//
//  BSTextDataModel.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/18.
//  Copyright © 2016年 LinBin. All rights reserved.
//
#import "NSDate+LBDate.h"
#import "BSTextDataModel.h"

@implementation BSTextDataModel
{
    CGFloat _cellHeight;
    
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
        //底部工具条
        _cellHeight += bottomViewH + marign;
        

    }
    
    return _cellHeight;

}

/**
 *  处理时间显示样式
 */

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] dateIntervalWithFromDate:create];;
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}
//
//- (NSString *)create_time {
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
//    NSDate *creatDate = [formatter dateFromString:_create_time];
//    if (creatDate.isThisYear) {//今年
//        
//        if (creatDate.isToday) {//今天
//            NSDateComponents *components = [[NSDate date] dateIntervalWithFromDate:creatDate];
//            if (components.hour >= 1) {//大于一小时
//                return [NSString stringWithFormat:@"%zd小时前",components.hour];
//            } else if (components.minute >= 1) {    //大于一分 少于一小时
//                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
//            } else {  //小于一分钟
//                return @"刚刚";
//            }
//            
//        } else if (creatDate.isYesterday){//昨天
//            formatter.dateFormat = @"昨天 HH:mm:ss";
//            return [formatter stringFromDate:creatDate];
//        } else {//非今天昨天
//            formatter.dateFormat = @"MM-dd HH:mm:ss";
//            return  [formatter stringFromDate:creatDate];
//        }
//        
//    } else {//非今年
//        
//        return  _create_time;
//    }
//
//}
@end
