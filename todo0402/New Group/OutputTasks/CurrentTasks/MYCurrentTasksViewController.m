//
//  MYCurrentTasksViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCurrentTasksViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface MYCurrentTasksViewController ()

@end

@implementation MYCurrentTasksViewController

@synthesize supportRequestsTasks, currentTasks, supportDate, tableView, listOfCategories, menu, categories;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menu.hidden = YES;
}

- (void) retrieveTasks {
    supportRequestsTasks = [RequestsTasks sharedInstance];
    listOfCategories = [[NSMutableArray alloc] init];
    currentTasks = [[NSMutableArray alloc] init];
    categories = [[NSMutableDictionary alloc] init];
    
    NSArray *overdueTasks = [supportRequestsTasks overdueTasks];
    [self addObjectToOutput:overdueTasks andListOfCategories:@"Просроченные" andKey:@"overdue"];
    
    NSArray *todayTasks = [supportRequestsTasks todayTasks];
    NSLog(@"%@", todayTasks);
    [self addObjectToOutput:todayTasks andListOfCategories:@"Сегодня" andKey:@"today"];
    
    NSArray *tomorrowTasks = [supportRequestsTasks tomorrowTasks];
    [self addObjectToOutput:tomorrowTasks andListOfCategories:@"Завтра" andKey:@"tomorrow"];
    
    NSArray *weaklyTasks = [supportRequestsTasks weaklyTasks];
    [self addObjectToOutput:weaklyTasks andListOfCategories:@"Следующие 7 дней" andKey:@"weakly"];
    
    NSArray *tasksInPerspective = [supportRequestsTasks tasksInPerspective];
    [self addObjectToOutput:tasksInPerspective andListOfCategories:@"Задачи в перспективе" andKey:@"perspective"];
}

#pragma mark - Формирование вывода задач по категориям

- (void) addObjectToOutput:(NSArray*)tasks andListOfCategories:(NSString*)name andKey:(NSString*)key {
    if ([tasks count] > 0) {
        [currentTasks addObject:tasks];
        [listOfCategories addObject:name];
        [categories setObject:@"YES" forKey:key];
    }
}

#pragma mark - Navigation

- (IBAction)cancel:(id)sender {
    MainViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"listSegue"]) {
        MYListOfCategoriesTableViewController *embed = segue.destinationViewController;
        embed.listOfCategories = [[NSMutableArray alloc] init];
        embed.categories = [[NSMutableDictionary alloc] init];
        [self retrieveTasks];
        embed.listOfCategories = listOfCategories;
        embed.categories = categories;
    }
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%ld", [currentTasks count]);
    return [currentTasks count];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[currentTasks objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self titleForSection:section];    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    supportDate = [Date sharedInstance];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currentTasksTableCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"currentTasksTableCell"];
    }
    
    NSArray* mainCell = [[currentTasks objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UILabel *labelForName = (UILabel *)[cell viewWithTag:1];
    labelForName.text = [mainCell valueForKey:@"name"];
    
    
    UILabel *labelForDate = (UILabel *)[cell viewWithTag:2];
    NSDictionary *dateDictionary = [supportDate dateAndTimeForLabel:[mainCell valueForKey:@"date"]];
    
    NSString *date = [NSString stringWithFormat:@"%@, %@",
                      [dateDictionary objectForKey:@"date"],
                      [dateDictionary objectForKey:@"time"]];
    labelForDate.text = date;
    
    UIButton *button = (UIButton *)[cell viewWithTag:3];
    [button setImage:[UIImage imageNamed:@"checkbox_no_select"] forState:UIControlStateNormal];
    
    return cell;
}

#pragma mark - Названия секций для таблицы

- (NSString*) titleForSection:(NSInteger)section {
    if (section == 0) {
        return [[listOfCategories objectAtIndex:0] uppercaseString];
    } else if (section == 1) {
        return [[listOfCategories objectAtIndex:1] uppercaseString];
    } else if (section == 2) {
        return [[listOfCategories objectAtIndex:2] uppercaseString];
    } else if (section == 3) {
        return [[listOfCategories objectAtIndex:3] uppercaseString];
    } else {
        return [[listOfCategories objectAtIndex:4] uppercaseString];
    }
}


#pragma mark - Обработка действий с задачами

- (IBAction)makeTaskDone:(id)sender {
    UIButton *button = (UIButton *)sender;
    supportRequestsTasks = [RequestsTasks sharedInstance];
    
    [button setImage:[UIImage imageNamed:@"checkbox_select"] forState:UIControlStateNormal];
    
//    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:button, @"button", nil];
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(targetMethod:)
//                                   userInfo:info
//                                    repeats:NO];
}

//- (void) targetMethod:(NSTimer*)timer {
//    NSDictionary *info = [timer userInfo];
//
//    UIButton *button = info[@"button"];
//
//    UITableViewCell *buttonCell = (UITableViewCell *)button.superview.superview;
//    UITableView* table = (UITableView *)[buttonCell superview];
//    NSIndexPath* pathOfTheCell = [table indexPathForCell:buttonCell];
//
//    NSInteger row = [pathOfTheCell row];
//    NSInteger section = [pathOfTheCell section];
//
//    NSManagedObject* managed = [[currentTasks objectAtIndex:section] objectAtIndex:row];
//
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Tasks" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//
//    NSError* error = nil;
//    [managed setValue:[NSNumber numberWithBool:YES] forKey:@"isDone"];
//
//    [context refreshObject:managed mergeChanges:NO];
//    if(![context save:&error]) {
//        NSLog(@"Error editing  - error:%@", error);
//    } else {
//        NSLog(@"dwad");
//    }
//    [self retrieveTasks];
//
//    [self.tableView reloadData];
//}

- (IBAction)openMenu:(id)sender {
    menu.hidden = !menu.hidden;
    
    MYListOfCategoriesTableViewController *listController = [self.storyboard instantiateViewControllerWithIdentifier:@"listOfCategories"];
    listController.listOfCategories = listOfCategories;
    
    if (menu.hidden) {
        [(UIButton*)sender setImage:[UIImage imageNamed:@"icon_no_expanded_filter.png"] forState:UIControlStateNormal];
    } else {
        [(UIButton*)sender setImage:[UIImage imageNamed:@"icon_expanded_filter.png"] forState:UIControlStateNormal];
    }
}

@end
