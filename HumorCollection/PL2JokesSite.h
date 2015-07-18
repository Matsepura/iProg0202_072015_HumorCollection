//
//  PL2JokesSite.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PL2JokeCategory;

@interface PL2JokesSite : NSManagedObject

@property (nonatomic, retain) NSString * encoding;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *categories;
@end

@interface PL2JokesSite (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(PL2JokeCategory *)value;
- (void)removeCategoriesObject:(PL2JokeCategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
