//
//  ViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "MYCustomMenu.h"
#import "MYCreateTaskViewController.h"
#import "MYImportantTasksViewController.h"
#import "MYUrgentTasksViewController.h"
#import "MYPersonalTasksViewController.h"
#import "MYDoneTasksViewController.h"
#import "MYCurrentTasksViewController.h"
#import "RequestsTasks.h"

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)menu:(id)sender;

@property (strong, nonatomic) RequestsTasks* supportRequestsTasks;
@property (strong, nonatomic) IBOutlet UIView *sideView;
@property (strong, nonatomic) IBOutlet UITableView *sideBar;
@property (strong, nonatomic) NSMutableArray *data;

@end

