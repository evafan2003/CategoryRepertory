//
//  NSDictionary+decription.m
//  iCarService
//
//  Created by David Li on 2018/1/31.
//

#import "NSDictionary+decription.h"

@implementation NSDictionary (decription)
- (NSString *)descriptionWithLocale:(id)locale
{
    
    NSArray *allKeys = [self allKeys];
    
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    
    for (NSString *key in allKeys) {
        
        id value= self[key];
        
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
        
    }
    [str appendString:@"}"];
    return str;
}

@end
