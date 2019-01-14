//
//  MYCreateTaskTableViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCreateTaskTableViewController.h"
#import "MYCreateTaskViewController.h"
#import "MYCreateTaskDateViewController.h"
#import "MYCreateTaskTimeViewController.h"


@interface MYCreateTaskTableViewController ()

@end

@implementation MYCreateTaskTableViewController

@synthesize name, support;


- (void)viewDidLoad {
    
    [super viewDidLoad];

    support = [Date sharedInstance];
    NSDate *date = [NSDate date];
    NSDictionary *dateAndTime = [support dateAndTimeForLabel:date];
    
    self.timeForLabel.text = [dateAndTime objectForKey:@"time"];
    self.dateForLabel.text = [dateAndTime objectForKey:@"date"];
    self.date = [dateAndTime objectForKey:@"dateObject"];
    
    // Отслеживание нажатий на экране
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
    [handleTap setCancelsTouchesInView:NO];
}

- (void) handleEndEditing {
    [self.view endEditing:YES];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        MYCreateTaskDateViewController *dateViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"dateTask"];
        
        dateViewController.dateDateView = [self date];
        dateViewController.delegate = self; 
        [self.navigationController pushViewController:dateViewController animated:YES];
        
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        MYCreateTaskTimeViewController *timeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"timeTask"];
        
        timeViewController.dateTimeView = [self date];
        timeViewController.delegate = self;
        [self.navigationController pushViewController:timeViewController animated:YES];
    }
}

#pragma mark - Обработка поля ввода имени задачи

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.name]) {
        [self.name resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Запись даты и времени в label, полученных с контроллеров выбора даты

- (void)addItemViewControllerDate:(MYCreateTaskDateViewControllerDelegate *)controller didFinishEnteringItem:(NSDate *)dateFromDelegate {
    self.date = dateFromDelegate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"dd.MM.y"];
    NSString *dateString = [formatter stringFromDate:dateFromDelegate];
    
    [self dateForLabel].text = dateString;
}

- (void)addItemViewControllerTime:(MYCreateTaskTimeViewControllerDelegate *)controller didFinishEnteringItem:(NSDate *)dateFromDelegate {
    self.date = dateFromDelegate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"HH.mm"];
    NSString *timeString = [formatter stringFromDate:dateFromDelegate];
    
    [self timeForLabel].text = timeString;
}
@end
