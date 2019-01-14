//
//  MYCreateTaskTimeViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"

NS_ASSUME_NONNULL_BEGIN

@class MYCreateTaskTimeViewControllerDelegate;

@protocol MYCreateTaskTimeViewControllerDelegate <NSObject>

- (void)addItemViewControllerTime:(MYCreateTaskTimeViewControllerDelegate *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface MYCreateTaskTimeViewController : UIViewController

@property (nonatomic, weak) id <MYCreateTaskTimeViewControllerDelegate> delegate;
@property (strong, nonatomic) Date* support;

@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (nonatomic, weak) NSString *timeFromTable;
@property (strong, nonatomic) NSDate* dateTimeView;

- (IBAction)cancel:(id)sender;
- (IBAction)selectTime:(id)sender;

@end

NS_ASSUME_NONNULL_END
