//
//  PL2JokeCategory+Parsing.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokeCategory.h"

@interface PL2JokeCategory (Parsing)

+ (instancetype)categoryFromJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context;

@end
