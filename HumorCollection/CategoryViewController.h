//
//  CategoryViewController.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PSRCoreDataTableViewController.h"

@class PL2JokesSite;

@interface CategoryViewController : PSRCoreDataTableViewController

@property (nonatomic, strong) PL2JokesSite *site;

@end
