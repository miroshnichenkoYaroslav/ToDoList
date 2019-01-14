//
//  MYCustomCell.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/5/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYCustomMenu.h"

@implementation MYCustomMenu

- (instancetype) initWithImage:(NSString*)image textForLabel:(NSString*)label {
    self = [super init];
    
    if (self) {
        _image = image;
        _label = label;
    }
    
    return self;
}

- (instancetype) initWithImage:(NSString*)image textForLabel:(NSString*)label textColor:(NSDictionary*) color {
    self = [super init];
    
    if (self) {
        _image = image;
        _label = label;
        _RGB = color;
    }

    return self;
}

- (NSString*)description {
    return [NSString stringWithFormat:@"%p", self];
}
@end
