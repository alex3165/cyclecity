//
//  DCLogViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCLogViewController.h"
#import "DCTrackService.h"

#import "DCViewController.h"

@interface DCLogViewController ()
    //@property (nonatomic, strong) DCUser *actualUser;
    
@end

@implementation DCLogViewController

DCViewController *secondController;



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor DC_bgColor];
    
    // Initialisation de mes objets Requêtes et de mon service de tracking !
    UIImage *myimage = [UIImage imageNamed:@"logo_ss-02.png"];
    self.logoView = [[UIImageView alloc] initWithImage:myimage ];
    //[secondController adsdSubview:self.logoView];
    
    self.trackService = [[DCTrackService alloc] init];
    secondController = [[DCViewController alloc]init];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


-(IBAction)saisieReturn:(id)sender
{
  [sender resignFirstResponder];
}

- (IBAction)valider:(id)sender {
    
    [self.trackService loginWithLoginAndPassword:self.login.text password:self.mdp.text success:^(NSDictionary *datas){
        
        [[DCUser currentUser] fillWithDictionary:datas];
        
        [self.navigationController pushViewController:secondController animated:true];
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];

}


@end
