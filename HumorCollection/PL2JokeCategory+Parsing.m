//
//  PL2JokeCategory+Parsing.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokeCategory+Parsing.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation PL2JokeCategory (Parsing)

+ (instancetype)categoryFromJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context
{
    /*  site	:	bash.im
     
     name	:	bash
     
     url	:	http://bash.im
     
     parsel	:	.text
     
     encoding	:	windows-1251
     
     linkpar	:	/quote/
     
     desc	:	Цитатник Рунета
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",json[@"desc"]];
    NSArray *sites = [PL2JokeCategory MR_findAllWithPredicate:predicate inContext:context];
    NSParameterAssert(sites.count <= 1);
    
    //find or create site
    PL2JokeCategory *aSite = sites.firstObject;
    if (!aSite){
        aSite = [PL2JokeCategory MR_createEntityInContext:context];
    }
    
    [aSite updateWithJSON:json];
    
    return aSite;
}

- (void)updateWithJSON:(NSDictionary *)json
{
    self.name = json[@"desc"];
}

@end
