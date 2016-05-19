//
//  NSDate+LBDate.h
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/19.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LBDate)
/**
 *  时间差
 *
 *  @param date 要对比的时间
 *
 *  @return 时间差
 */
- (NSDateComponents *)dateIntervalWithFromDate:(NSDate *)date;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
@end
