//
//  DCLocationService.m
//  duracity
//
//  Created by RIEUX Alexandre on 04/03/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCLocationService.h"

@implementation DCLocationService

- (id)init
{
    self = [super init];
    
    
    if (self) {
            self.locationManager = [[CLLocationManager alloc] init];
        
        
           if ([CLLocationManager locationServicesEnabled])
            {
                self.locationManager.delegate = self;
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                self.locationManager.distanceFilter = 100.0f;
                [self.locationManager startUpdatingLocation];
            }
        
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{

    CLLocationCoordinate2D coordinate = [newLocation coordinate];
    CLLocationSpeed userspeed = [newLocation speed];

    [[DCUser currentUser] setLatitude:[[NSNumber numberWithDouble:coordinate.latitude] stringValue]];
    [[DCUser currentUser] setLongitude:[[NSNumber numberWithDouble:coordinate.longitude] stringValue]];
    
    NSLog(@"%f %f %f",coordinate.latitude,coordinate.longitude,userspeed);

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{

}

@end
