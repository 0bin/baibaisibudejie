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
