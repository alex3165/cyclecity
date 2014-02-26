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
DCUserService *currentUser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialisation de mes objets Requêtes et de mon service de tracking !
    
    self.trackService = [[DCTrackService alloc] init];
    secondController = [[DCViewController alloc]init];
    currentUser = [[DCUserService alloc]init];
    
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
        [currentUser createUserWithIdAndName:[datas valueForKey:@"id"] name:[datas valueForKey:@"name"]];//[datas valueForKey:@"name"]
        
        NSLog(@"%@",currentUser.getUser);
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


@end
