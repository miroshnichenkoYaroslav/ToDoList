//
//  MYSupport.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/11/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Date : NSObject

+ (Date*) sharedInstance;

- (NSDictionary*) dateAndTimeForLabel:(NSDate*) date;

- (NSDate*) formatDateToOutputTasks:(NSDate*) date;
@end

NS_ASSUME_NONNULL_END
