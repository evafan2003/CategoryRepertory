//
//  NSDate+Agenda.h
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Agenda)

- (NSDate *)firstDayOfTheMonth;

- (NSDate *)lastDayOfTheMonth;
- (NSInteger)weekDay;
- (NSInteger)dayComponents;
- (NSInteger)quartComponents;
- (NSInteger)monthComponents;
- (NSInteger)yearComponents;
+ (NSCalendar *)gregorianCalendar;
+ (NSLocale *)locale;

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate;

- (NSComparisonResult)compareWithMonth:(NSDate*)date;

- (BOOL)isToday;

- (NSDate*)preMonth;
- (NSDate*)nextMonth;

- (NSDate*)preYear;
- (NSDate*)nextYear;

- (NSDate *)dayOfNum:(NSInteger)numDay;

- (NSDate *)startingDate;
- (NSDate *)endingDate;
+ (NSArray *)weekdaySymbols;
+ (NSString *)monthSymbolAtIndex:(NSInteger)index;

+ (NSDate*)dateFromString:(NSString*)string;
+ (NSString*)stringFromDate:(NSDate*)date;
+ (NSString*)stringYearFromDate:(NSDate *)date;
/**
 *  通过时间戳，获取时间
 *
 *  @param timeInterval 时间戳
 *
 *  @return <#return value description#>
 */
+ (NSString*)stringFromDateTime:(NSTimeInterval)timeInterval;
+ (NSString*)stringFromDateTime:(NSTimeInterval)timeInterval format:(NSString *)format;
/**
 *  将UTC日期字符串转为本地时间字符串
 *
 *  @param utcDate 2013-08-03T04:53:51+0000
 *
 *  @return <#return value description#>
 */
+(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
@end
