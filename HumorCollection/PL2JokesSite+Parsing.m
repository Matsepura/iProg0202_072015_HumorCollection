//
//  PL2JokesSite+Parsing.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PL2JokesSite+Parsing.h"

#import "PL2JokeCategory+Parsing.h"

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
    
    return aSite;
}

- (void)updateWithJSON:(NSDictionary *)json
{
    self.name       = json[@"site"];
    self.encoding   = json[@"encoding"];
}

+ (void)sitesFromJSONs:(NSArray *)jsons inContext:(NSManagedObjectContext *)context
{
    //Тут лежит массив из категорий сайта
    for (NSArray *siteCategories in jsons) {
        //пробежимся по каждой категории
        for (NSDictionary *json in siteCategories) {
            PL2JokesSite *site = [PL2JokesSite siteFromJSON:json inContext:context];
            PL2JokeCategory *category = [PL2JokeCategory categoryFromJSON:json inContext:context];
            [site addCategoriesObject:category];
        }
    }
}

@end
















