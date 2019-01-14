//
//  MYUrgentTasksViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYUrgentTasksViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#import "MYCustomTask.h"

@interface MYUrgentTasksViewController ()

@end

@implementation MYUrgentTasksViewController

@synthesize data, support, supportRequestsTasks;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [[NSMutableArray alloc] init];
    
    supportRequestsTasks = [RequestsTasks sharedInstance];
    NSArray* urgentTasks = [supportRequestsTasks urgentTasks];
    support = [Date sharedInstance];
    
    for (NSManagedObject * item in urgentTasks) {
        NSDate *date = [support formatDateToOutputTasks:[item valueForKey:@"date"]];
        
        [self nameTask:[item valueForKey:@"name"]
                andImageTask:@"menu_task_urgently"
                andDate:(NSString*)date];
    }
}

- (void) nameTask:(NSString*)task andImageTask:(NSString*)imageTask andDate:(NSString*) date {
    MYCustomTask *cell = [[MYCustomTask alloc] init];
    
    [data addObject:[cell initWithImageTask:imageTask andTaskName:task andTimeForLabel:date]];
}

#pragma mark - Navigation

- (IBAction)cancel:(id)sender {
    MainViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    
    [self.navigationController pushViewController:view animated:YES];
}

# pragma mark - Table View

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"urgentTasksTableCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"urgentTasksTableCell"];
    }
    
    MYCustomTask *mainCell = [data objectAtIndex:indexPath.row];
    
    UIImageView *imageTask = (UIImageView *)[cell viewWithTag:1];
    imageTask.image = [UIImage imageNamed:mainCell.imageTask];
    
//    UIImageView *imageTask = (UIImageView *)[cell viewWithTag:2];
    
    imageTask.image = [UIImage imageNamed:mainCell.imageTask];
    
    UILabel *label = (UILabel *)[cell viewWithTag:3];
    label.text = mainCell.taskName;
    
    UILabel *labelTime = (UILabel *)[cell viewWithTag:4];
    labelTime.text = mainCell.labelTime;
    
    return cell;
}

@end
