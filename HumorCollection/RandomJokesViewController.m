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

@property (strong, nonatomic) NSDictionary *json;

@end

@implementation RandomJokesViewController

-(void)getRandomJoke
{
    
    NSLog(@"pognali!");
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.umori.li/api/random?num=1"]];
    NSError *error = nil;
    
    NSDictionary *json = [[NSDictionary alloc] init];
    json = [NSJSONSerialization JSONObjectWithData:data
                                           options:0
                                             error:&error];
    
    

    NSLog(@"%@", [json objectForKey:@"site"]);
    
    NSLog(@"%@", json);
    
    
    
    
}

//-(NSString*) textOnRandomJokeTextView: (NSDictionary *)json
//{
//    NSString *randomJoke = [NSString new];
//    randomJoke = [NSString stringWithFormat:json[@"elementPureHtml"]];
//    //self.RandomJokeTextView.text
//    NSLog(@"%@", randomJoke);
//    return randomJoke;
//}


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

