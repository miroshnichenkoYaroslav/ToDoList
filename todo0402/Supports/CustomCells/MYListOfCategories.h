//
//  MYListOfCategories.h
//  todo0402
//
//  Created by Ярослав Мирошниченко on 1/12/19.
//  Copyright © 2019 Ярослав Мирошниченко. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYListOfCategories : NSObject

@property (weak, nonatomic) NSString* categoryName;
@property (weak, nonatomic) NSString* selectImage;
@property (weak, nonatomic) NSString* key;

- (instancetype) initWithSelectImage:(NSString*)selectImage andCategoryName:(NSString*)categoryName andKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
