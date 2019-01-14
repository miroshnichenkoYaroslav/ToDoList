//
//  MYCreateTaskTableViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYCreateTaskDateViewController.h"
#import "MYCreateTaskTimeViewController.h"
#import "Date.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYCreateTaskTableViewController : UITableViewController <UITextFieldDelegate, MYCreateTaskDateViewControllerDelegate, MYCreateTaskTimeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UISwitch *isImportantTask;
@property (strong, nonatomic) IBOutlet UISwitch *isPersonalTask;
@property (strong, nonatomic) IBOutlet UISwitch *isUrgentTask;

@property (strong, nonatomic) IBOutlet UILabel *dateForLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeForLabel;
@property (strong, nonatomic) NSDate* date;

@property (strong, nonatomic) Date* support;

@end

NS_ASSUME_NONNULL_END
