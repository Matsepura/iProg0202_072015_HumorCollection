//
//  PL2JokesSite+Parsing.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokesSite.h"

@interface PL2JokesSite (Parsing)

+ (instancetype)siteFromJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context;

@end
