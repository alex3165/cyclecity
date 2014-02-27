//
//  DCLogViewController.h
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "DCViewController.h"

#import "DCRequests.h"
#import "DCTrackService.h"
//#import "DCUserService.h"

@interface DCLogViewController : UIViewController



// Toute la partie UI de l'application
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *mdp;
@property (weak, nonatomic) IBOutlet UIButton *validate;

// Objet Request pour faire appel aux différentes requêtes
@property (nonatomic, strong) DCTrackService *trackService;
//@property (nonatomic,strong) DCUserService *currentUser;


// Action Return du clavier ios
- (IBAction)saisieReturn :(id)sender;


@end
