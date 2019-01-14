//
//  MYCustomDoneTableCell.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/7/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCustomTask.h"

@implementation MYCustomTask

- (instancetype) initWithImageTask:(NSString*)imageTask andTaskName:(NSString*)taskName andTimeForLabel:(NSString*)time {
    self = [super init];
    
    if (self) {
        _taskName = taskName;
        _labelTime = time;
        _imageTask = imageTask;
    }
    
    return self;
}

@end
