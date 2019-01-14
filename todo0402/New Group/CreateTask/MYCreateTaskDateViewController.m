//
//  MYCreateTaskDateViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCreateTaskDateViewController.h"
#import "MainViewController.h"

@protocol MYCreateTaskDateViewControllerDelegate <NSObject>

- (void)addItemViewController:(MYCreateTaskDateViewController *)controller didFinishEnteringItem:(NSString *)item;

@end

@interface MYCreateTaskDateViewController ()

@end

@implementation MYCreateTaskDateViewController

@synthesize dateDateView, datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self datePicker].date = dateDateView;

    // Do any additional setup after loading the view.
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectDate:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(addItemViewControllerDate)]) {
        [self.delegate addItemViewControllerDate:self didFinishEnteringItem:datePicker.date];
        [self.navigationController popViewControllerAnimated:YES];

//    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
