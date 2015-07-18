//
//  PL2JokeItem+Parsing.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokeItem+Parsing.h"

#import "MagicalRecord.h"

@implementation PL2JokeItem (Parsing)

+ (instancetype)jokeItemWithJSON:(NSDictionary *)json inContext:(NSManagedObjectContext *)context
{
    /*
    site	:	bash.im
    
    name	:	bash
    
    desc	:	Цитатник Рунета
    
    link	:	/url.html?url=http%3A%2F%2Fbash.im%2Fquote%2F434745
    
    elementPureHtml	:	ххх: У меня, например, прочно отложилось в голове, что торговать интернетом в роуминге выгоднее, чем наркотиками, оружием и проститутками в нагрузку
    
    1		{5}
     */
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"link = %@",json[@"link"]];
    NSArray *sites = [PL2JokeItem MR_findAllWithPredicate:predicate inContext:context];
    NSParameterAssert(sites.count <= 1);
    
    //find or create site
    PL2JokeItem *aSite = sites.firstObject;
    if (!aSite){
        aSite = [PL2JokeItem MR_createEntityInContext:context];
    }
    
    [aSite updateWithJSON:json];
    
    return aSite;
}

- (void)updateWithJSON:(NSDictionary *)json
{
    self.link   = json[@"link"];
    self.text   = json[@"elementPureHtml"];
}

@end
