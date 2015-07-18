//
//  PL2JokesSite+Parsing.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokesSite+Parsing.h"

#import "MagicalRecord.h"


@implementation PL2JokesSite (Parsing)

+ (instancetype)siteFromJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context
{
/*  site	:	bash.im
     
     name	:	bash
     
     url	:	http://bash.im
     
     parsel	:	.text
     
     encoding	:	windows-1251
     
     linkpar	:	/quote/
     
     desc	:	Цитатник Рунета
*/
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",json[@"site"]];
    NSArray *sites = [PL2JokesSite MR_findAllWithPredicate:predicate inContext:context];
    NSParameterAssert(sites.count <= 1);
    
    //find or create site
    PL2JokesSite *aSite = sites.firstObject;
    if (!aSite){
        aSite = [PL2JokesSite MR_createEntityInContext:context];
    }
    
    [aSite updateWithJSON:json];
    
    return sites.firstObject;
}

- (void)updateWithJSON:(NSDictionary *)json
{
    self.name       = json[@"site"];
    self.url        = json[@"url"];
    self.encoding   = json[@"encoding"];
}

@end







