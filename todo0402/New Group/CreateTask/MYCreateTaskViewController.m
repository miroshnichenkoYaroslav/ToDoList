//
//  CreateTaskViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCreateTaskViewController.h"
#import "MYCreateTaskTableViewController.h"
#import "MainViewController.h"
#import "MYCreateTaskTimeViewController.h"

@interface MYCreateTaskViewController ()

@end

@implementation MYCreateTaskViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Navigation

- (IBAction)cancel:(id)sender {
    MainViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)saveTask:(id)sender {
    MYCreateTaskTableViewController *controller = [self.childViewControllers firstObject];
    
    if (![self checkSwitch:[controller isImportantTask]] && ![self checkSwitch:[controller isPersonalTask]] && ![self checkSwitch:[controller isUrgentTask]]) {
        [self makeAlertTitle:@"" andMessage:@"Необходимо выбрать не менее одной категории" andAction:@"Ok!" andCallBack:^{}];
    } else if ([[controller name].text length] != 0 ) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        NSManagedObject *task = [NSEntityDescription insertNewObjectForEntityForName:@"Tasks" inManagedObjectContext:context];
        
        [task setValue:[controller name].text forKey:@"name"];
        
        BOOL isImportantSwitchOn = [self checkSwitch:[controller isImportantTask]];
        [task setValue:[NSNumber numberWithBool:isImportantSwitchOn] forKey:@"isImportant"];
        
        BOOL isPersonalSwitchOn = [self checkSwitch:[controller isPersonalTask]];
        [task setValue:[NSNumber numberWithBool:isPersonalSwitchOn] forKey:@"isPersonal"];
        
        BOOL isUrgentSwitchOn = [self checkSwitch:[controller isPersonalTask]];
        [task setValue:[NSNumber numberWithBool:isUrgentSwitchOn] forKey:@"isUrgent"];
        
        [task setValue:[NSNumber numberWithBool:NO] forKey:@"isDone"];
        [task setValue:[controller date] forKey:@"date"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            [controller name].backgroundColor = nil;
            [self makeAlertTitle:@"" andMessage:@"Задача успешно добавлена" andAction:@"Оk!" andCallBack:^{
                    [controller name].text = @"";
                    [[controller isImportantTask] setOn:YES];
                    [[controller isPersonalTask] setOn:NO];
                    [[controller isUrgentTask] setOn:NO];
            }];
        }
    } else {
        [self makeAlertTitle:@"" andMessage:@"Поле название обязательно для заполнения" andAction:@"Ok!" andCallBack:^{
            [controller name].backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];

        }];
    }
}

- (BOOL) checkSwitch:(UISwitch*)sender {
    if ([sender isOn]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - Alert

- (void) makeAlertTitle:(NSString*)title andMessage:(NSString*)message andAction:(NSString*)action andCallBack:(void (^)(void))block {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:action style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:actionOk];
    
    [self presentViewController:alert animated:YES completion:^{
        block();
    }];
}
@end
