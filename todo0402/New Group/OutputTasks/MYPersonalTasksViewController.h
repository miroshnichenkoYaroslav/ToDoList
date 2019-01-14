//
//  MYPersonalTasksViewController.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Date.h"
#import "RequestsTasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface MYPersonalTasksViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)cancel:(id)sender;

@property (strong, nonatomic) Date* support;
@property (strong, nonatomic) RequestsTasks* supportRequestsTasks;
@property (strong, nonatomic) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
