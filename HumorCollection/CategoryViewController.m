//
//  CategoryViewController.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "CategoryViewController.h"
#import "JokesViewController.h"
#import "PL2JokeCategory.h"

@implementation CategoryViewController

- (NSString *)cellReuseIdentifier
{
    return @"SiteCell";
}

- (NSFetchRequest *)dataRequest
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([PL2JokeCategory class])];
    request.predicate = [NSPredicate predicateWithFormat:@"site = %@",self.site];
    
    //Сортировка
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES]];
    return request;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[JokesViewController class]]){
        JokesViewController *vc = segue.destinationViewController;
        vc.category = sender;
    }
}

- (void)configureCell:(UITableViewCell *)aCell withItem:(PL2JokeCategory *)item
{
    aCell.textLabel.text = item.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PL2JokeCategory *category = (PL2JokeCategory *)[self itemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"Show Jokes" sender:category];
}

@end
