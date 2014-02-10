//
//  DCLogViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCLogViewController.h"

@interface DCLogViewController ()
    @property (weak, nonatomic) DCViewController *secondcontroller;
@end

@implementation DCLogViewController

NSString * text_login;
NSString * text_mdp;


- (void)viewDidLoad
{
    [super viewDidLoad];    
    self.BaseURLString = @"http://kalyptusprod.fr/app/app/";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saisieReturn:(id)sender
{
  [sender resignFirstResponder];
}
- (IBAction)valider:(id)sender {
    
    text_login = self.login.text;
    text_mdp = self.mdp.text;
    
    NSString *loginurl = [NSString stringWithFormat:@"%@login.php", self.BaseURLString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys: text_login, @"login", text_mdp, @"mdp", nil];
    [manager POST:loginurl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

// ------------- On passe l'id et la key dans une variable du second controller et on change de controller ----------------------
        
        DCViewController *secondcontroller = [[DCViewController alloc] init];
        secondcontroller.idkey = [responseObject mutableCopy];
        [self.navigationController pushViewController:secondcontroller animated:YES];
        //NSLog(@"JSON: %@", responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

}



@end
