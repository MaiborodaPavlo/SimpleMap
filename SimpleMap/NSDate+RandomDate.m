//
//  NSDate+RandomDate.m
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "NSDate+RandomDate.h"

@implementation NSDate (RandomDate)

- (NSDate *)randomDateForStudent {
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDate *today = [[NSDate alloc] init];
    
    NSDateComponents *comps = [currentCalendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: today];
    
    [comps setYear: [comps year] - 16 - arc4random() % 45];
    
    [comps setMonth:arc4random_uniform(12)];
    
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit: NSCalendarUnitDay inUnit: NSCalendarUnitMonth forDate:[currentCalendar dateFromComponents:comps]];
    
    [comps setDay: arc4random_uniform((int)range.length)];
    
    // Normalise the time portion
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    [comps setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    
    return [currentCalendar dateFromComponents: comps];
}

@end
