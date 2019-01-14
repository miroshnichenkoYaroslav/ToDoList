//
//  ViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//
#import "MainViewController.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@interface MainViewController () {
    BOOL isSideViewOpen;
}
@end

@implementation MainViewController

@synthesize sideView, sideBar, data, supportRequestsTasks;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sideBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sideView.hidden = NO;
    
    isSideViewOpen = YES;
    
    data = [[NSMutableArray alloc] init];
    
    NSDictionary* rgb = [[NSDictionary alloc] initWithObjectsAndKeys:
                        [NSNumber numberWithFloat:0.1], @"red",
                        [NSNumber numberWithFloat:0.2], @"green",
                        [NSNumber numberWithFloat:0.3], @"blue",
                        [NSNumber numberWithFloat:1], @"alpha",
                        nil];
    
    [self addItemToMenu:@"Добавить задачу" imageName:@"menu_task_add.png"
             colorLabel:rgb];
    [self addItemToMenu:@"Текущие" imageName:@"menu_task_current.png"];
    [self addItemToMenu:@"Важные" imageName:@"menu_task_important.png"];
    [self addItemToMenu:@"Срочные" imageName:@"menu_task_urgently.png"];
    [self addItemToMenu:@"Личные" imageName:@"menu_task_personal.png"];
    [self addItemToMenu:@"Выполненные" imageName:@"menu_task_done.png"];
}

#pragma mark - формирование меню

- (void) addItemToMenu:(NSString*)label imageName:(NSString*)image colorLabel:(NSDictionary*) RGB {
    MYCustomMenu *cell = [[MYCustomMenu alloc] init];
    
    [data addObject:[cell initWithImage:image textForLabel:label textColor:RGB]];
}

- (void) addItemToMenu:(NSString*)label imageName:(NSString*)image {
    MYCustomMenu *cell = [[MYCustomMenu alloc] init];
    
    [data addObject:[cell initWithImage:image textForLabel:label]];
}

# pragma mark - table Menu

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    MYCustomMenu *mainCell = [data objectAtIndex:indexPath.row];
    
    UIImageView *image = (UIImageView *)[cell viewWithTag:1];
    image.image = [UIImage imageNamed:mainCell.image];
    
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    label.text = mainCell.label;
    
    
//    if (mainCell.RGB) {
//        label.textColor = [UIColor colorWithRed:[[mainCell.RGB objectForKey:@"red"] floatValue]
//                                    green:[[mainCell.RGB objectForKey:@"green"] floatValue]
//                                    blue:[[mainCell.RGB objectForKey:@"blue"] floatValue]
//                                    alpha:[[mainCell.RGB objectForKey:@"alpha"] floatValue]];
//    }
    UILabel *count = (UILabel *)[cell viewWithTag:3];
    
    if (indexPath.row == 0) {
        label.textColor = [UIColor blueColor];
    } else if (indexPath.row == 1) {
        supportRequestsTasks = [RequestsTasks sharedInstance];
        
        NSInteger countCurrent = [[supportRequestsTasks overdueTasks] count] +
                                [[supportRequestsTasks todayTasks] count]  +
                                [[supportRequestsTasks tomorrowTasks] count] +
                                [[supportRequestsTasks weaklyTasks] count] +
                                [[supportRequestsTasks tasksInPerspective] count];
        
        count.text = [NSString stringWithFormat:@"%ld", countCurrent];
    } else if (indexPath.row == 2) {
        supportRequestsTasks = [RequestsTasks sharedInstance];
        count.text = [NSString stringWithFormat:@"%ld", [[supportRequestsTasks importantTasks] count]];
        
    } else if (indexPath.row == 3) {
        supportRequestsTasks = [RequestsTasks sharedInstance];
        count.text = [NSString stringWithFormat:@"%ld", [[supportRequestsTasks urgentTasks] count]];
        
    } else if (indexPath.row == 4) {
        supportRequestsTasks = [RequestsTasks sharedInstance];
        count.text = [NSString stringWithFormat:@"%ld", [[supportRequestsTasks personalTasks] count]];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MYCreateTaskViewController *createTask = [self.storyboard instantiateViewControllerWithIdentifier:@"createTask"];
        
        [self.navigationController pushViewController:createTask animated:YES];
    } else if (indexPath.row == 1) {
        
        MYCurrentTasksViewController *currentTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"currentTasks"];
        [self.navigationController pushViewController:currentTasks animated:YES];
        
    } else if (indexPath.row == 2) {
        
        MYImportantTasksViewController *importantTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"importantTasks"];
        
        [self.navigationController pushViewController:importantTasks animated:YES];
        
    } else if (indexPath.row == 3) {
        
        MYUrgentTasksViewController *urgentTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"urgentTasks"];
        
        [self.navigationController pushViewController:urgentTasks animated:YES];
        
    } else if (indexPath.row == 4) {
        
        MYPersonalTasksViewController *personalTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"personalTasks"];
        
        [self.navigationController pushViewController:personalTasks animated:YES];
    
    } else if (indexPath.row == 5) {
        
        MYDoneTasksViewController *doneTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"doneTasks"];
        
        [self.navigationController pushViewController:doneTasks animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

# pragma mark - обработка бокового меню

- (IBAction)menu:(id)sender {
    sideView.hidden = NO;
    sideBar.hidden = NO;
    
    [self.view bringSubviewToFront:sideView];
    
    if(!isSideViewOpen) {
        isSideViewOpen = YES;
        
        [sideView setFrame:CGRectMake(0, 80, 0, SCREEN_HEIGHT)];
        [sideBar setFrame:CGRectMake(0, 0, 0, SCREEN_HEIGHT)];
        
        [UIView beginAnimations:@"TableAnimation" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        [sideView setFrame:CGRectMake(0, 80, 315, SCREEN_HEIGHT)];
        [sideBar setFrame:CGRectMake(0, 0, 315, SCREEN_HEIGHT)];
        
        [UIView commitAnimations];
    } else {
        isSideViewOpen = NO;
        sideView.hidden = YES;
        sideBar.hidden = YES;
        
        [sideView setFrame:CGRectMake(0, 80, 315, SCREEN_HEIGHT)];
        [sideBar setFrame:CGRectMake(0, 0, 315, SCREEN_HEIGHT)];
        
        [UIView beginAnimations:@"TableAnimation" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        
        [sideView setFrame:CGRectMake(0, 80, 0, SCREEN_HEIGHT)];
        [sideBar setFrame:CGRectMake(0, 0, 0, SCREEN_HEIGHT)];
        
        [UIView commitAnimations];
        
        MYCurrentTasksViewController *currentTasks = [self.storyboard instantiateViewControllerWithIdentifier:@"currentTasks"];
        [self.navigationController pushViewController:currentTasks animated:YES];
    }
}
@end
