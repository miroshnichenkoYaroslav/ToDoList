//
//  MYDoneTasksViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYDoneTasksViewController.h"
#import "MainViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "MYCustomTask.h"

@interface MYDoneTasksViewController ()

@end

@implementation MYDoneTasksViewController

@synthesize data, support, supportRequestsTasks;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [[NSMutableArray alloc] init];
    
    supportRequestsTasks = [RequestsTasks sharedInstance];
    NSArray* doneTasks = [supportRequestsTasks doneTasks];
    support = [Date sharedInstance];
    
    for (NSManagedObject * item in doneTasks) {
        NSDate *date = [support formatDateToOutputTasks:[item valueForKey:@"date"]];
        
        [self nameTask:[item valueForKey:@"name"]
                andImageTask:@"menu_task_done"
                andTime:(NSString*)date];
    }
}

- (void) nameTask:(NSString*)task andImageTask:(NSString*)imageTask andTime:(NSString*) time{
    MYCustomTask *cell = [[MYCustomTask alloc] init];
    
    [data addObject:[cell initWithImageTask:imageTask andTaskName:task andTimeForLabel:time]];
}

- (IBAction)cancel:(id)sender {
    MainViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    
    [self.navigationController pushViewController:view animated:YES];
}

# pragma mark - table view
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doneTasksTableCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"doneTasksTableCell"];
    }
    
    MYCustomTask *mainCell = [data objectAtIndex:indexPath.row];
    
    UIImageView *imageTask = (UIImageView *)[cell viewWithTag:1];
    imageTask.image = [UIImage imageNamed:mainCell.imageTask];
        
    UILabel *label = (UILabel *)[cell viewWithTag:3];
    label.text = mainCell.taskName;
    
    UILabel *labelTime = (UILabel *)[cell viewWithTag:4];
    labelTime.text = mainCell.labelTime;
    
    return cell;
}
@end
