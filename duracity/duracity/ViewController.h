//
//  ViewController.h
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreLocation/CoreLocation.h>
#import "AFNetworking.h"
#import "DCViewController.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>{

    CLLocationManager* locationManager;
    
}

@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) DCViewController *secondcontroller;
@property (weak, nonatomic) IBOutlet UITextField *mdp;


@end
