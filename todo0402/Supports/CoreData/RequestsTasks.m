//
//  RequestsTasks.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/11/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "RequestsTasks.h"
#import "AppDelegate.h"

NSString *const Entity = @"Tasks";

@implementation RequestsTasks

+ (RequestsTasks*)sharedInstance {
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}

# pragma mark - Выборки задач по временному промежутку для вывода текущих задач

- (NSArray*) overdueTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription* description = [NSEntityDescription entityForName:Entity inManagedObjectContext:context];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:Entity];
    
    NSDate *date = [NSDate date];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date < %@ && isDone == NO", date];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) todayTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription* description = [NSEntityDescription entityForName:Entity inManagedObjectContext:context];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:Entity];
    
    NSDate *date = [NSDate date];
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date];
    components.day = components.day - 1;
    
    NSDate *yesterdayMidnight = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@ && isDone == NO",
                              yesterdayMidnight, date];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) tomorrowTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription* description = [NSEntityDescription entityForName:Entity inManagedObjectContext:context];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:Entity];
    
    NSDate *date = [NSDate date];
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date];
    components.day = components.day + 2;
    
    NSDate *tomorrowMidnight = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@ && isDone == NO", date, tomorrowMidnight];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) weaklyTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription* description = [NSEntityDescription entityForName:Entity inManagedObjectContext:context];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:Entity];
    
    NSDate *date = [NSDate date];
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date];
    components.day = components.day + 2;
    
    NSDate *weaklyMidnight1 = [[NSCalendar currentCalendar] dateFromComponents:components];
    components.day = components.day + 7;
    
    NSDate *weaklyMidnight2 = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date >= %@ AND date <= %@ && isDone == NO", weaklyMidnight1, weaklyMidnight2];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) tasksInPerspective {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSEntityDescription* description = [NSEntityDescription entityForName:Entity inManagedObjectContext:context];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:Entity];
    
    NSDate *date = [NSDate date];
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date];
    
    components.day = components.day + 9;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date > %@ && isDone == NO", date];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) importantTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Tasks"];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isImportant == YES && isDone == NO"];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) personalTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Tasks"];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isPersonal == YES && isDone == NO"];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) urgentTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Tasks"];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isUrgent == YES && isDone == NO"];
    [request setPredicate:predicate];

    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}

- (NSArray*) doneTasks {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Tasks"];
    
    NSEntityDescription* description = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isDone == YES"];
    
    [request setPredicate:predicate];
    [request setEntity:description];
    [request setResultType:NSDictionaryResultType];
    
    NSError* requestError = nil;
    
    return [context executeFetchRequest:request error:&requestError];
}
@end
