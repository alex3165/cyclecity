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

@interface DCLogViewController : UIViewController {
    NSArray *jsonloginresponse;
}

@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *mdp;
@property (weak, nonatomic) IBOutlet UIButton *validate;
@property (weak, nonatomic) NSString *BaseURLString;

- (IBAction)saisieReturn :(id)sender;


@end
