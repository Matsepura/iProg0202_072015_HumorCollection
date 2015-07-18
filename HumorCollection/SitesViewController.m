//
//  SitesViewController.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "SitesViewController.h"

#import "PL2JokesSite+Parsing.h"

#import "AFNetworking.h"
#import "MagicalRecord.h"

@interface SitesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SitesViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateSites];
}

- (void)updateSites
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.umori.li/api/sources"]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer new];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"УРА!%@",responseObject);
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            //Тут лежит массив из категорий сайта
            for (NSArray *siteCategories in responseObject) {
                //пробежимся по каждой категории
                for (NSDictionary *json in siteCategories) {
                    [PL2JokesSite siteFromJSON:json inContext:localContext];
                }
            }

        } completion:^(BOOL contextDidSave, NSError *error) {
            NSLog(@"updated: %@ sites in dataBase",[PL2JokesSite MR_numberOfEntities]);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Ой! %@",error);
    }];
    [operation start];
}

- (void)clearSitesInContext:(NSManagedObjectContext *)localContext
{
    NSArray *sites = [PL2JokesSite MR_findAllInContext:localContext];
    
    for (PL2JokesSite *site  in sites) {
        [site MR_deleteEntityInContext:localContext];
    }
}

@end













