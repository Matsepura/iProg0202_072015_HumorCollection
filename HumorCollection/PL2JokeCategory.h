//
//  PL2JokeCategory.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PL2JokeItem, PL2JokesSite;

@interface PL2JokeCategory : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSSet *jokes;
@property (nonatomic, retain) PL2JokesSite *site;
@end

@interface PL2JokeCategory (CoreDataGeneratedAccessors)

- (void)addJokesObject:(PL2JokeItem *)value;
- (void)removeJokesObject:(PL2JokeItem *)value;
- (void)addJokes:(NSSet *)values;
- (void)removeJokes:(NSSet *)values;

@end
