//
//  NSDate+Extend.m
//  categoryKitDemo
//
//  Created by zhanghao on 2016/7/23.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

+ (NSCalendar *)clsCalendar {
    return [[self alloc] zh_calendar];
}

- (NSCalendar *)zh_calendar {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
#else
    return [NSCalendar currentCalendar]
#endif
}

- (NSInteger)year {
    return [[[self zh_calendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[self zh_calendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[self zh_calendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[self zh_calendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[self zh_calendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[self zh_calendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)weekday {
    return [[[self zh_calendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSString *)dayFromWeekday {
    return [NSDate dayFromWeekday:self];
}

- (NSString *)dayFromWeekday2 {
    return [NSDate dayFromWeekday2:self];
}

- (NSString *)dayFromWeekday3 {
    return [NSDate dayFromWeekday3:self];
}

+ (NSString *)dayFromWeekday:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)dayFromWeekday2:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)dayFromWeekday3:(NSDate *)date {
    switch([date weekday]) {
        case 1:
            return @"Sunday";
            break;
        case 2:
            return @"Monday";
            break;
        case 3:
            return @"Tuesday";
            break;
        case 4:
            return @"Wednesday";
            break;
        case 5:
            return @"Thursday";
            break;
        case 6:
            return @"Friday";
            break;
        case 7:
            return @"Saturday";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ymdFormatJoinedByString:(NSString *)string {
    return [NSString stringWithFormat:@"yyyy%@MM%@dd", string, string];
}

+ (NSString *)ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self ymdFormat], [self hmsFormat]];
}

+ (NSString *)ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)dmyFormat {
    return @"dd/MM/yyyy";
}

+ (NSString *)myFormat {
    return @"MM/yyyy";
}

+ (NSString *)currentTimeString {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

+ (NSString *)stringWithFormat:(NSString *)format {
    return [[NSDate date] stringWithFormat:format];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

// (NSDate => Timestamp)
+ (NSInteger)timestampFromDate:(NSDate *)date {
    return [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
}

// (Timestamp => NSDate)
+ (NSDate *)dateFromTimestamp:(NSInteger)timestamp {
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

// (TimeString => Timestamp)
+ (NSInteger)timestampFromTimeString:(NSString *)timeString formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    // 将字符串按formatter转成NSDate
    NSDate *date = [formatter dateFromString:timeString];
    return [self timestampFromDate:date];
}

// (Timestamp => TimeString)
+ (NSString *)timeStringFromTimestamp:(NSInteger)timestamp formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *timeDate = [self dateFromTimestamp:timestamp];
    return [formatter stringFromDate:timeDate];
}

+ (NSInteger)getNowTimestampWithFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    return [self timestampFromDate:[NSDate date]];
}

+ (NSInteger)getSumOfDaysMonth:(NSInteger)month inYear:(NSInteger)year {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSString *dateString = [NSString stringWithFormat:@"%ld-%lu", (long)year, month];
    NSDate *date = [formatter dateFromString:dateString];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSRange range = [[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian] rangeOfUnit:NSCalendarUnitDay
                                     inUnit:NSCalendarUnitMonth
                                    forDate:date];
    return range.length;
#else
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                     inUnit: NSMonthCalendarUnit
                                    forDate:date];
    return range.length;
#endif
}

// 获取当前的"年月日时分"
+ (NSArray<NSString *> *)getCurrentTimeComponents {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy,MM,dd,HH,mm"];
    NSDate *date = [NSDate date];
    NSString *time = [formatter stringFromDate:date];
    return [time componentsSeparatedByString:@","];
}


- (NSComparisonResult)compareDateString1:(NSString *)dateString1
                             dateString2:(NSString *)dateString2
                               formatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:dateString1];
    date2 = [formatter dateFromString:dateString2];
    return [date1 compare:date2];
}

- (BOOL)isInPast {
    return ([self compare:[NSDate date]] == NSOrderedAscending);
}

- (BOOL)isInFuture {
    return ([self compare:[NSDate date]] == NSOrderedDescending);
}

- (BOOL)zh_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (BOOL)isToday {
    return [self zh_isSameDay:[NSDate date]];
}

+ (NSDate *)backward:(NSInteger)backwardN unitType:(NSCalendarUnit)unit {
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setValue:backwardN forComponent:unit];
    
    NSDate *dateFromDateComponentsAsTimeQantum = [[self clsCalendar]
                                                  dateByAddingComponents:dateComponentsAsTimeQantum
                                                  toDate:[NSDate date]
                                                  options:0];
    return dateFromDateComponentsAsTimeQantum;
}

+ (NSDate *)forward:(NSInteger)forwardN unitType:(NSCalendarUnit)unit {
    return [self backward:-forwardN unitType:unit];
}
/////
#pragma mark -- 获取日
+ (NSInteger)day:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    
    return components.day;
}

#pragma mark -- 获取月
+ (NSInteger)month:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.month;
}

#pragma mark -- 获取年
+ (NSInteger)year:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate     *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday         = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}

#pragma mark -- 获取当前月共有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInLastMonth.length;
}

#pragma mark -- 获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *date          = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString        *dateString    = [dateFormatter stringFromDate:date];
    
    return dateString;
}

#pragma mark -- 设置日期格式
+ (NSDateFormatter *)setDataFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}

#pragma mark -- 计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *startDate     = [dateFormatter dateFromString:startDateStr];
    NSDate          *endDate       = [dateFormatter dateFromString:endDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return delta;
}




@end
