//
//  NSDate+Agenda.m
//  CalendarIOS7
//
//  Created by Jerome Morissard on 3/3/14.
//  Copyright (c) 2014 Jerome Morissard. All rights reserved.
//

#import "NSDate+Agenda.h"
#import <objc/runtime.h>

const char * const JmoCalendarStoreKey = "jmo.calendar";
const char * const JmoLocaleStoreKey = "jmo.locale";

@implementation NSDate (Agenda)

#pragma mark - Getter and Setter

+ (void)setGregorianCalendar:(NSCalendar *)gregorianCalendar
{
    objc_setAssociatedObject(self, JmoCalendarStoreKey, gregorianCalendar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSCalendar *)gregorianCalendar
{
    NSCalendar* cal = objc_getAssociatedObject(self, JmoCalendarStoreKey);
    if (nil == cal) {
        cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [cal setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [cal setLocale:[self locale]];
        [self setGregorianCalendar:cal];
        
    }
    return cal;
}

+ (void)setLocal:(NSLocale *)locale
{
    objc_setAssociatedObject(self, JmoLocaleStoreKey, locale, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSLocale *)locale
{
    NSLocale *locale  = objc_getAssociatedObject(self, JmoLocaleStoreKey);
    if (nil == locale) {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
        [self setLocal:locale];
    }
    return locale;
}

#pragma mark -

-(NSDate *)dayOfNum:(NSInteger)numDay{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comps setDay:numDay];
    NSDate *day = [gregorian dateFromComponents:comps];
    return day;
}


- (NSDate *)firstDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comps setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comps];
    return firstDayOfMonthDate;
}

- (NSDate *)lastDayOfTheMonth
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents* comps = [gregorian components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday fromDate:self];
    
    // set last of month
    [comps setMonth:[comps month]+1];
    [comps setDay:0];
    NSDate *lastDayOfMonthDate = [gregorian dateFromComponents:comps];
    return lastDayOfMonthDate;
}

+ (NSInteger)numberOfMonthFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    return [gregorian components:NSCalendarUnitMonth fromDate:fromDate toDate:toDate options:0].month+1;
}

+ (NSInteger)numberOfDaysInMonthForDate:(NSDate *)fromDate
{
    NSCalendar *gregorian = [self gregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:fromDate];
    return range.length;
}

- (NSInteger)weekDay
{
    NSCalendar *gregorian = [self.class gregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekday = [comps weekday]-1;//0 周日
    return weekday ;
}

- (NSComparisonResult)compareWithMonth:(NSDate *)date
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if([today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedSame;
    }
    if([today month] < [otherDay month] &&
       [today year] <= [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedDescending;
    }
    if([today month] > [otherDay month] &&
       [today year] >= [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedAscending;
    }
    
    if([today year] < [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedDescending;
    }
    if([today year] > [otherDay year] &&
       [today era] == [otherDay era]) {
        return NSOrderedAscending;
    }
    return NO;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *otherDay = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSLog(@"%ld,%ld,%ld,%ld,\n%ld,%ld,%ld,%ld,",(long)[today day],(long)[today month],(long)[today year],(long)[today era],(long)[otherDay day],(long)[otherDay month],(long)[otherDay year],(long)[otherDay era]);
    if([today day] == [otherDay day] &&
       [today month] == [otherDay month] &&
       [today year] == [otherDay year] &&
       [today era] == [otherDay era]) {
        return YES;
    }
    return NO;
}

- (NSDate*)preMonth
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [comps setMonth:[comps month]-1];
    return [calendar dateFromComponents:comps];
}
- (NSDate*)nextMonth
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [comps setMonth:[comps month]+1];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)preYear{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [comps setYear:[comps year]-1];
    return [calendar dateFromComponents:comps];
}
- (NSDate*)nextYear{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    [comps setYear:[comps year]+1];
    return [calendar dateFromComponents:comps];
}

- (NSInteger)quartComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];
    return comps.hour*4+(comps.minute/15);
}

- (NSInteger)dayComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitDay fromDate:self];
    return comps.day;
}


- (NSInteger)monthComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitMonth fromDate:self];
    return comps.month;
}

- (NSInteger)yearComponents
{
    NSCalendar *calendar = [self.class gregorianCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear fromDate:self];
    return comps.year;
}

- (NSDate *)startingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

- (NSDate *)endingDate
{
    NSDateComponents *components = [[NSDate gregorianCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:self];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    return [[NSDate gregorianCalendar] dateFromComponents:components];
}

+ (NSArray *)weekdaySymbols
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableArray *upper = [NSMutableArray new];
    for (NSString *day in [dateFormatter shortWeekdaySymbols]) {
        [upper addObject:day.uppercaseString];
    }
    return  upper;
}

+ (NSString *)monthSymbolAtIndex:(NSInteger)index
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *months = [dateFormatter monthSymbols];
    return months[index - 1];
}

+ (NSDate*)dateFromString:(NSString*)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:string];
    return destDate;
}

+ (NSString*)stringYearFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy"];
    NSString *destDate= [dateFormatter stringFromDate:date];
    return destDate;
}

+ (NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSString *destDate= [dateFormatter stringFromDate:date];
    return destDate;
}
+ (NSString*)stringFromDateTime:(NSTimeInterval)timeInterval
{
   NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSString *destDate= [dateFormatter stringFromDate:date];
    return destDate;
}
+ (NSString*)stringFromDateTime:(NSTimeInterval)timeInterval format:(NSString *)format
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: format];
    NSString *destDate= [dateFormatter stringFromDate:date];
    return destDate;
}
+(NSString *)getLocalDateFormateUTCDate:(NSString *)oldTime
{
    NSString *newSt=[NSString stringWithFormat:@"%@+0000",oldTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyyMMdd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:newSt];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    NSString *temp=[NSString stringWithFormat:@"%lld",(long long) [dateFormatted timeIntervalSince1970]*1000];

    return temp;
}
@end
