//
//  NSDate+Formatter.m
//  iCarCustomer
//
//  Created by hefei on 2017/7/18.
//  Copyright © 2017年 dycd. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)

+ (NSDate *) dateWithTimeStr:(NSString *)string Formatter:(NSString *)formatStr {
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr.length?formatStr:@"yyyy-MM-dd";
    return [formatter dateFromString:string];
}

@end
