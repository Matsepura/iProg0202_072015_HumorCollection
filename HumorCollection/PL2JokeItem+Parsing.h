//
//  PL2JokeItem+Parsing.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokeItem.h"

@interface PL2JokeItem (Parsing)

+ (instancetype)jokeItemWithJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context;

@end
