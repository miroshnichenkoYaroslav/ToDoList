//
//  MYListOfCategoriesTableViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/12/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYCurrentTasksViewController.h"
#import "MYListOfCategories.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYListOfCategoriesTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

// только для вывода
@property (strong, nonatomic) NSMutableArray *listOfCategories;

@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) NSMutableDictionary* categories;

@property (strong, nonatomic) RequestsTasks* supportRequestsTasks;

@end

NS_ASSUME_NONNULL_END
