//
//  NSArray+decription.m
//  iCarService
//
//  Created by David Li on 2018/1/31.
//

#import "NSArray+decription.h"

@implementation NSArray (decription)
- (NSString *)descriptionWithLocale:(id)locale

{
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        
        [str appendFormat:@"\t%@, \n", obj];
        
    }
    
    [str appendString:@")"];
    
    return str;
    
}

@end
