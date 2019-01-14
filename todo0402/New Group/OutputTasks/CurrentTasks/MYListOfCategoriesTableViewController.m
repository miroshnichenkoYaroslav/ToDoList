//
//  MYListOfCategoriesTableViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/12/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYListOfCategoriesTableViewController.h"

@interface MYListOfCategoriesTableViewController ()

@end

@implementation MYListOfCategoriesTableViewController

@synthesize listOfCategories, data, supportRequestsTasks, categories;

- (void)viewDidLoad {
    [super viewDidLoad];
    supportRequestsTasks = [RequestsTasks sharedInstance];
    data = [[NSMutableArray alloc] init];
    for (NSString* category in listOfCategories) {
        
        if ([category isEqualToString:@"Просроченные"]) {
            [self addNameCategory:category andImage:@"icon_select_filter" andKey:@"overdue"];
        } else if ([category isEqualToString:@"Сегодня"]) {
            [self addNameCategory:category andImage:@"icon_select_filter" andKey:@"today"];
        } else if ([category isEqualToString:@"Завтра"]) {
            [self addNameCategory:category andImage:@"icon_select_filter" andKey:@"tomorrow"];
        } else if ([category isEqualToString:@"Следующие 7 дней"]) {
            [self addNameCategory:category andImage:@"icon_select_filter" andKey:@"weakly"];
        } else if ([category isEqualToString:@"Задачи в перспективе"]) {
            [self addNameCategory:category andImage:@"icon_select_filter" andKey:@"perspective"];
        }
    }
}

- (void) addNameCategory:(NSString*)nameCategory andImage:(NSString*)image andKey:(NSString*) key {
    MYListOfCategories *listOfCategory = [[MYListOfCategories alloc] init];
    
    [data addObject:[listOfCategory initWithSelectImage:@"icon_select_filter" andCategoryName:nameCategory andKey:key]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfCategories count];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listOfCategories"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"listOfCategories"];
    }
    
    MYListOfCategories *mainCell = [data objectAtIndex:indexPath.row];
    
    UILabel *label = (UILabel*)[cell viewWithTag:1];
    label.text = mainCell.categoryName;
    
    UIImageView *image = (UIImageView*)[cell viewWithTag:2];        
    image.image = [UIImage imageNamed:mainCell.selectImage];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    MYListOfCategories *row = [data objectAtIndex:indexPath.row];
    
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    MYCurrentTasksViewController *currentController = [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 1];
    
    if ([row.selectImage isEqualToString:@""]) {
        row.selectImage = @"icon_select_filter";
        
        [currentController.categories setObject:@"YES" forKey:row.key];
        
        [self dataForTableFromController:currentController];
    } else {
        row.selectImage = @"";
        
        [currentController.categories setObject:@"NO" forKey:row.key];
        
        [self dataForTableFromController:currentController];
        
    }
    [self.tableView reloadData];
    [currentController.tableView reloadData];
}

- (void) dataForTableFromController:(MYCurrentTasksViewController*)controller {
    controller.currentTasks = nil;
    controller.listOfCategories = nil;
    
    controller.currentTasks = [[NSMutableArray alloc] init];
    controller.listOfCategories = [[NSMutableArray alloc] init];
    
    if ([controller.categories[@"overdue"] isEqualToString:@"YES"]) {
        NSArray *overdueTasks = [supportRequestsTasks overdueTasks];
        [controller.currentTasks addObject:overdueTasks];
        [controller.listOfCategories addObject:@"Просроченные"];
    }
    
    if ([controller.categories[@"today"] isEqualToString:@"YES"]) {
        NSArray *todayTasks = [supportRequestsTasks todayTasks];
        [controller.currentTasks addObject:todayTasks];
        [controller.listOfCategories addObject:@"Сегодня"];
    }
    
    if ([controller.categories[@"tomorrow"] isEqualToString:@"YES"]) {
        NSArray *tomorrowTasks = [supportRequestsTasks tomorrowTasks];
        [controller.currentTasks addObject:tomorrowTasks];
        [controller.listOfCategories addObject:@"Завтра"];
    }
    
    if ([controller.categories[@"weakly"] isEqualToString:@"YES"]) {
        NSArray *weaklyTasks = [supportRequestsTasks weaklyTasks];
        [controller.currentTasks addObject:weaklyTasks];
        [controller.listOfCategories addObject:@"Следующие 7 дней"];
    }
    
    if ([controller.categories[@"perspective"] isEqualToString:@"YES"]) {
        NSArray *tasksInPerspective = [supportRequestsTasks tasksInPerspective];
        [controller.currentTasks addObject:tasksInPerspective];
        [controller.listOfCategories addObject:@"Задачи в перспективе"];
    }
}
@end
