//
//  RequestsTasks.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/11/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const Entity;

NS_ASSUME_NONNULL_BEGIN

@interface RequestsTasks : NSObject

+ (RequestsTasks*)sharedInstance;

- (NSArray*) overdueTasks;
- (NSArray*) todayTasks;
- (NSArray*) tomorrowTasks;
- (NSArray*) weaklyTasks;
- (NSArray*) tasksInPerspective;
- (NSArray*) importantTasks;
- (NSArray*) personalTasks;
- (NSArray*) urgentTasks;
- (NSArray*) doneTasks;
@end

NS_ASSUME_NONNULL_END
