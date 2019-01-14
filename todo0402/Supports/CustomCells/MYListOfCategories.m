//
//  MYListOfCategories.m
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/12/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import "MYListOfCategories.h"

@implementation MYListOfCategories

- (instancetype) initWithSelectImage:(NSString*)selectImage andCategoryName:(NSString*)categoryName andKey:(NSString*)key {
    self = [super init];
    
    if (self) {
        _selectImage = selectImage;
        _categoryName = categoryName;
        _key = key;
    }
    
    return self;
}

@end
