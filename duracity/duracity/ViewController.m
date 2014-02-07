//
//  ViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad
{
    [super viewDidLoad];    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)valider:(id)sender {
    
       NSLog(@"TEST");
       DCViewController *secondcontroller = [[DCViewController alloc] init];
       [self.navigationController pushViewController:secondcontroller animated:YES];
}



@end
