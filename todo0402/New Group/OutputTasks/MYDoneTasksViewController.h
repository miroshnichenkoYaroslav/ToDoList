//
//  MYDoneTasksViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import <CoreData/CoreData.h>
#import "Date.h"
#import "RequestsTasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYDoneTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) RequestsTasks* supportRequestsTasks;
@property (strong, nonatomic) Date* support;

- (IBAction)cancel:(id)sender;

@end

NS_ASSUME_NONNULL_END
