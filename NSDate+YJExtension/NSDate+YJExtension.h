//
//  NSDate+YJExtension.h
//
//  Created by Joye on 2017/8/29.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YJExtension)

// 获取给定日期对应的是星期几
- (NSString *)currentWeekDayByDate:(NSDate *)date format:(NSString *)format;
// 获取给定字符串对应的日期是星期几
- (NSString *)currentWeekDayByString:(NSString *)string format:(NSString *)format;

// 获取给定日期所在周的日期范围
- (NSString *)currentWeekTimeRangeByDate:(NSDate *)date;

// 根据给定日期计算明天日期---返回NSDate类型
- (NSDate *)tomorrowDateByDate:(NSDate *)date;
// 根据给定日期计算明天日期---返回字符串类型
- (NSString *)tomorrowStringByDate:(NSDate *)date format:(NSString *)format;

// 根据日期返回对应的是哪个星座
- (NSString *)currentConstellationByDate:(NSDate *)date;

@end

