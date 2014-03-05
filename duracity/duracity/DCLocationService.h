//
//  DCLocationService.h
//  duracity
//
//  Created by RIEUX Alexandre on 04/03/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "DCUser.h"

@interface DCLocationService : NSObject <CLLocationManagerDelegate>

@property(nonatomic,strong) CLLocationManager* locationManager;

@end
