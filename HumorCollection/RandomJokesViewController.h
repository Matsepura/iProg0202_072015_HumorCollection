//
//  RandomJokesViewController.h
//  HumorCollection
//
//  Created by Semen on 20.07.15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "PSRCoreDataTableViewController.h"

#import <UIKit/UIKit.h>

@interface RandomJokesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *RandomJokeTextView;
@property (weak, nonatomic) IBOutlet UIButton *RandomJokeButton;

@end
