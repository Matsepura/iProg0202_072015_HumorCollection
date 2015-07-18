//
//  JokesViewController.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "JokesViewController.h"

#import "JokeViewController.h"

#import "MagicalRecord.h"
#import "AFNetworking.h"

#import "PL2JokeCategory.h"
#import "PL2JokeItem+Parsing.h"

@interface JokesViewController ()

@end

@implementation JokesViewController

- (NSString *)cellReuseIdentifier
{
    return @"SiteCell";
}

- (NSFetchRequest *)dataRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PL2JokeItem class])];
    request.predicate = [NSPredicate predicateWithFormat:@"category = %@",self.category];
    
    //Сортировка
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"text"
                                                              ascending:YES]];
    return request;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(PL2JokeItem *)sender
{
    if ([segue.destinationViewController isKindOfClass:[JokeViewController class]]){
        JokeViewController *vc = segue.destinationViewController;
        vc.html = sender.text;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.fetchedResultsController.fetchedObjects.count == 0){
        [self getJokes];
    }
    
}

- (void)configureCell:(UITableViewCell *)aCell withItem:(PL2JokeItem *)item
{
    aCell.textLabel.text = [item.text substringToIndex:40];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PL2JokeItem *item = [self  itemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"Show Joke" sender:item];
}


- (void)getJokes
{
    //http://www.umori.li/api/get?site=bash.im&name=bash&num=100
    
    NSString *url = [NSString stringWithFormat:@"http://www.umori.li/api/get?site=%@&num=100",self.category.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer new];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"УРА!%@",responseObject);
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            PL2JokeCategory *category = [self.category MR_inContext:localContext];
            for (NSDictionary *json in responseObject){
                [category addJokesObject:[PL2JokeItem jokeItemWithJSON:json
                                                             inContext:localContext]];
            }
            
        } completion:^(BOOL contextDidSave, NSError *error) {
            NSLog(@"updated: %@ sites in dataBase",[PL2JokeItem MR_numberOfEntities]);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Ой! %@",error);
    }];
    [operation start];
}

@end
