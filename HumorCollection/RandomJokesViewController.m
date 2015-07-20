//
//  RandomJokesViewController.m
//  HumorCollection
//
//  Created by Semen on 20.07.15.
//  Copyright (c) 2015 Nikolay Shubenkov. All rights reserved.
//

#import "RandomJokesViewController.h"

#import "MagicalRecord.h"
#import "AFNetworking.h"

@interface RandomJokesViewController ()

@end

@implementation RandomJokesViewController

-(void)getRandomJoke
{
    NSString *url = [NSString stringWithFormat:@"http://www.umori.li/api/random?num=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSArray *responseObject) {
        NSLog(@"УРА!%@",responseObject);
        NSArray *elementPureHtml = [[NSArray alloc] initWithObjects:@"elementPureHtml", nil];
        
        NSDictionary *json = [[NSDictionary alloc] initWithObjects:responseObject forKeys:elementPureHtml];
        
        self.RandomJokeTextView.text = [NSString stringWithFormat:@"1"];
        
//        initWithObjects:responseObject forKeys: @"elementPureHtml"
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Ой! %@",error);
    }];
    
    

         
    
    
    [operation start];
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [self getRandomJoke];
    self.RandomJokeTextView.text = [NSString stringWithFormat:@"111"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
     
@end

