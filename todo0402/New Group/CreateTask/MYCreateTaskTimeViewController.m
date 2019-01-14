//
//  MYCreateTaskTimeViewController.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/6/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCreateTaskTimeViewController.h"
#import "MainViewController.h"

@interface MYCreateTaskTimeViewController ()

@end

@implementation MYCreateTaskTimeViewController

@synthesize dateTimeView, timePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self timePicker].date = dateTimeView;
}

- (IBAction)cancel:(id)sender {    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectTime:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(addItemViewControllerTime)]) {
        [self.delegate addItemViewControllerTime:self didFinishEnteringItem:timePicker.date];
        [self.navigationController popViewControllerAnimated:YES];
//    }
    
}


@end
