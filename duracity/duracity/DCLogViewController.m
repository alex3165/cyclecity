//
//  DCLogViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCLogViewController.h"
#import "DCTrackService.h"
//#import "DCUser.h"
#import "DCViewController.h"

@interface DCLogViewController ()
    
@end

@implementation DCLogViewController

NSString * text_login;
NSString * text_mdp;
DCViewController *secondController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialisation de mes objets Requêtes et de mon service de tracking !
    
    self.trackService = [[DCTrackService alloc] init];
    self.requests = [[DCRequests alloc] init];
    self.currentUser = [[DCUser alloc] init];
    
    secondController = [[DCViewController alloc]init];
   // [self.navigationController pushViewController:secondController animated:true]; // Pour debeug
}


-(IBAction)saisieReturn:(id)sender
{
  [sender resignFirstResponder];
}

- (IBAction)valider:(id)sender {
    
    text_login = self.login.text;
    text_mdp = self.mdp.text;
    
    [self.trackService loginWithLoginAndPassword:text_login password:text_mdp success:^(NSDictionary *datas){
        
        [self.navigationController pushViewController:secondController animated:true];

        self.currentUser.iduser = [datas valueForKey:@"id"];
        self.currentUser.key = [datas valueForKey:@"key"];
        self.currentUser.name = [datas valueForKey:@"name"];
        
        NSLog(@"%@",datas);
        NSLog(@"%@",self.currentUser);
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


@end
