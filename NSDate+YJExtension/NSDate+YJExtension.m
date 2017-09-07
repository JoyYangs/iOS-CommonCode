//
//  NSDate+YJExtension.m
//
//  Created by Joye on 2017/8/29.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "NSDate+YJExtension.h"

@implementation NSDate (YJExtension)

- (NSString *)currentWeekDayByDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:format];
    NSArray *array = [NSArray arrayWithObjects:@"",@"星期日",@"星期一",
                      @"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    return array[theComponents.weekday];
}

- (NSString *)currentWeekDayByString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:format];
    NSDate *date = [fm dateFromString:string];
    return [self currentWeekDayByDate:date format:format];
}


- (NSString *)currentWeekTimeRangeByDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [comp setDay:([comp day] + 1)];
    
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy.MM.dd"];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }
    
    NSDateComponents *dayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [dayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek = [calendar dateFromComponents:dayComp];
    
    [dayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek = [calendar dateFromComponents:dayComp];
    
    return [NSString stringWithFormat:@"%@-%@",[fm stringFromDate:firstDayOfWeek],[fm stringFromDate:lastDayOfWeek]];
}


- (NSDate *)tomorrowDateByDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day] + 1)];
    
    return [gregorian dateFromComponents:components];
}

- (NSString *)tomorrowStringByDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:format];
    return [fm stringFromDate:[self tomorrowDateByDate:date]];
}


- (NSString *)currentConstellationByDate:(NSDate *)date
{
    NSString *retStr = @"";
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM"];
    int i_month = 0;
    NSString *theMonth = [dateFormat stringFromDate:date];
    if([[theMonth substringToIndex:0] isEqualToString:@"0"]){
        i_month = [[theMonth substringFromIndex:1] intValue];
    }else{
        i_month = [theMonth intValue];
    }
    
    [dateFormat setDateFormat:@"dd"];
    int i_day = 0;
    NSString *theDay = [dateFormat stringFromDate:date];
    if([[theDay substringToIndex:0] isEqualToString:@"0"]){
        i_day = [[theDay substringFromIndex:1] intValue];
    }else{
        i_day = [theDay intValue];
    }
    
    switch (i_month) {
        case 1:
            if(i_day >= 1 && i_day <= 19){
                retStr = @"摩羯座";
            }
            if(i_day >= 20 && i_day <= 31){
                retStr = @"水瓶座";
            }
            break;
        case 2:
            if(i_day >= 1 && i_day <= 18){
                retStr = @"水瓶座";
            }
            if(i_day >= 19 && i_day <= 31){
                retStr = @"双鱼座";
            }
            break;
        case 3:
            if(i_day >= 1 && i_day <= 20){
                retStr = @"双鱼座";
            }
            if(i_day >= 21 && i_day <= 31){
                retStr = @"白羊座";
            }
            break;
        case 4:
            if(i_day >= 1 && i_day <= 19){
                retStr = @"白羊座";
            }
            if(i_day >= 20 && i_day <= 31){
                retStr = @"金牛座";
            }
            break;
        case 5:
            if(i_day >= 1 && i_day <= 20){
                retStr = @"金牛座";
            }
            if(i_day >= 21 && i_day <= 31){
                retStr = @"双子座";
            }
            break;
        case 6:
            if(i_day >= 1 && i_day <= 21){
                retStr = @"双子座";
            }
            if(i_day >= 22 && i_day <= 31){
                retStr = @"巨蟹座";
            }
            break;
        case 7:
            if(i_day >= 1 && i_day <= 22){
                retStr = @"巨蟹座";
            }
            if(i_day >= 23 && i_day <= 31){
                retStr = @"狮子座";
            }
            break;
        case 8:
            if(i_day >= 1 && i_day <= 22){
                retStr = @"狮子座";
            }
            if(i_day >= 23 && i_day <= 31){
                retStr = @"处女座";
            }
            break;
        case 9:
            if(i_day >= 1 && i_day <= 22){
                retStr = @"处女座";
            }
            if(i_day >= 23 && i_day <= 31){
                retStr = @"天秤座";
            }
            break;
        case 10:
            if(i_day >= 1 && i_day <= 23){
                retStr = @"天秤座";
            }
            if(i_day >= 24 && i_day <= 31){
                retStr = @"天蝎座";
            }
            break;
        case 11:
            if(i_day >= 1 && i_day <= 22){
                retStr = @"天蝎座";
            }
            if(i_day >= 23 && i_day <= 31){
                retStr = @"射手座";
            }
            break;
        case 12:
            if(i_day >= 1 && i_day <= 21){
                retStr = @"射手座";
            }
            if(i_day >= 21 && i_day <= 31){
                retStr = @"摩羯座";
            }
            break;
    }
    return retStr;
}

@end
