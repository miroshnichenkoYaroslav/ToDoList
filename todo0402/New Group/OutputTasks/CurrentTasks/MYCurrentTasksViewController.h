//
//  MYCurrentTasksViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"
#import "RequestsTasks.h"
#import "MYListOfCategoriesTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYCurrentTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Date* supportDate;
@property (strong, nonatomic) RequestsTasks* supportRequestsTasks;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray* currentTasks;
@property (strong, nonatomic) NSMutableArray* listOfCategories;
@property (strong, nonatomic) NSMutableDictionary* categories;

@property (strong, nonatomic) IBOutlet UIView *menu;

- (IBAction)cancel:(id)sender;

- (IBAction)makeTaskDone:(id)sender;

- (IBAction)openMenu:(id)sender;
- (IBAction)reload:(id)sender;

@end

NS_ASSUME_NONNULL_END
