//
//  MYSupport.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/11/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "Date.h"

@implementation Date

+ (Date*)sharedInstance {
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}

- (NSDictionary*) dateAndTimeForLabel:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH.mm"];
    NSString *timeString = [formatter stringFromDate:date];
    
    [formatter setDateFormat:@"dd.MM.y"];
    NSString *dateString = [formatter stringFromDate:date];
    
    NSDictionary* dateAndTime = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                        timeString, @"time",
                                                        dateString, @"date",
                                                        date, @"dateObject",
                                                        nil];

    return dateAndTime;
}

- (NSDate*) formatDateToOutputTasks:(NSDate*) date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    
    return (NSDate*)[dateFormatter stringFromDate:date];
}


@end
