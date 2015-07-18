//
//  SitesViewController.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "SitesViewController.h"

#import "CategoryViewController.h"

#import "PL2JokesSite+Parsing.h"

#import "AFNetworking.h"
#import "MagicalRecord.h"

@implementation SitesViewController

#pragma mark - Super

- (NSString *)cellReuseIdentifier
{
    return @"SiteCell";
}

- (NSFetchRequest *)dataRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PL2JokesSite class])];
    
//Сортировка
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES]];
    return request;
}

- (void)configureCell:(UITableViewCell *)aCell withItem:(PL2JokesSite *)item
{
    aCell.textLabel.text = item.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PL2JokesSite *site = (PL2JokesSite *)[self itemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"Show Category" sender:site];
}

#pragma mark - View Controller Life Cycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateSites];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[CategoryViewController class]]){
        CategoryViewController *vc = segue.destinationViewController;
        vc.site = sender;
    }
}

#pragma mark - Data Update

- (void)updateSites
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.umori.li/api/sources"]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer new];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"УРА!%@",responseObject);
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            [PL2JokesSite sitesFromJSONs:responseObject inContext:localContext];

        } completion:^(BOOL contextDidSave, NSError *error) {
            NSLog(@"updated: %@ sites in dataBase",[PL2JokesSite MR_numberOfEntities]);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Ой! %@",error);
    }];
    [operation start];
}

@end













