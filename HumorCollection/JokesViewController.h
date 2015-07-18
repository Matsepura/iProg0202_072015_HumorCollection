//
//  JokesViewController.h
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PSRCoreDataTableViewController.h"

#import "PL2JokeCategory.h"

@interface JokesViewController : PSRCoreDataTableViewController

@property (nonatomic, strong) PL2JokeCategory *category;

@end
