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
    CGRect _pictureFrame;
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

        }
        //底部工具条
        _cellHeight += bottomViewH + marign;
    }
    return _cellHeight;

}

/**
 *  处理时间显示样式
 */
- (NSString *)create_time {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *creatDate = [formatter dateFromString:_create_time];
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
        
        return  _create_time;
    }


}
@end
