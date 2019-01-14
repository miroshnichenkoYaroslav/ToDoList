//
//  CreateTaskViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "MYCreateTaskDateViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYCreateTaskViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *formCreate;

- (IBAction)cancel:(id)sender;
- (IBAction)saveTask:(id)sender;

@end

NS_ASSUME_NONNULL_END
