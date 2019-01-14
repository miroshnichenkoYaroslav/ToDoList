//
//  MYCreateTaskDateViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MYCreateTaskDateViewControllerDelegate;

@protocol MYCreateTaskDateViewControllerDelegate <NSObject>

- (void)addItemViewControllerDate:(MYCreateTaskDateViewControllerDelegate *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface MYCreateTaskDateViewController : UIViewController

@property (nonatomic, weak) id <MYCreateTaskDateViewControllerDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, weak) NSString *timeFromTable;
@property (nonatomic, strong) NSDate* dateDateView;

- (IBAction)cancel:(id)sender;
- (IBAction)selectDate:(id)sender;


@end

NS_ASSUME_NONNULL_END
