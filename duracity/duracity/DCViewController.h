//
//  DCViewController.h
//  duracity
//
//  Created by RIEUX Alexandre on 06/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <CoreLocation/CoreLocation.h>

@interface DCViewController : UIViewController <CLLocationManagerDelegate>{
    
    CLLocationManager* locationManager;
    
}



@end
