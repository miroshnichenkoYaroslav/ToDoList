//
//  MYCustomCell.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYCustomMenu : NSObject

@property(weak, nonatomic) NSString *label;
@property(weak, nonatomic) NSString *image;
@property(weak, nonatomic) NSDictionary *RGB;

- (instancetype) initWithImage:(NSString*)image textForLabel:(NSString*)label textColor:(NSDictionary*) color;

- (instancetype) initWithImage:(NSString*)image textForLabel:(NSString*)label;
@end

NS_ASSUME_NONNULL_END
