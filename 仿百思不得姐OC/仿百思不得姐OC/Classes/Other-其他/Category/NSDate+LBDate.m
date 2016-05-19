//
//  NSDate+LBDate.m
//  仿百思不得姐OC
//
//  Created by LinBin on 16/5/19.
//  Copyright © 2016年 LinBin. All rights reserved.
//

#import "NSDate+LBDate.h"

@implementation NSDate (LBDate)

-(NSDateComponents *)dateIntervalWithFromDate:(NSDate *)date {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |  NSCalendarUnitSecond;
    return  [calendar components:unit fromDate:date toDate:self options:0];


}

- (BOOL)isThisYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}

- (BOOL)isToday {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    return (nowComponents.year == selfComponents.year) && (nowComponents.month == selfComponents.month) && (nowComponents.day == selfComponents.day);
}

- (BOOL)isYesterday {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSDate *selfDate = [formatter dateFromString:[formatter stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    return (components.year == 0) && (components.month == 0) && (components.day == 1);
    
}
@end
