//
//  JokeViewController.m
//  HumorCollection
//
//  Created by Nikolay Shubenkov on 18/07/15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "JokeViewController.h"

@interface JokeViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation JokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadHTMLString:self.html baseURL:nil];
    // Do any additional setup after loading the view.
}

@end
