//
//  MYCustomDoneTableCell.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/7/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCustomTask : NSObject

@property(strong, nonatomic) NSString *taskName;
@property(strong, nonatomic) NSString *imageTask;
@property(strong, nonatomic) NSString *labelTime;

- (instancetype) initWithImageTask:(NSString*)imageTask andTaskName:(NSString*)taskName andTimeForLabel:(NSString*)time;

@end

NS_ASSUME_NONNULL_END
