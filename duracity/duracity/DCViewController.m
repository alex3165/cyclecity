//
//  DCViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 06/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCViewController.h"

@interface DCViewController ()
    @property (weak, nonatomic) DCLogViewController *firstcontroller;
@end

@implementation DCViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trackService = [[DCTrackService alloc] init];
    self.requests = [[DCRequests alloc] init];
    self.currentUser = [[DCUser alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    
    
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 100.0f;
        [locationManager startUpdatingLocation];
    }
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    //myposition = [newLocation description];
    
    CLLocationCoordinate2D coordinate = [newLocation coordinate];

    self.firstcontroller.currentUser.latitude = [NSString localizedStringWithFormat:@"%f",coordinate.latitude];
    self.firstcontroller.currentUser.longitude = [NSString localizedStringWithFormat:@"%f",coordinate.longitude];
    
}

- (IBAction)requestEvent:(id)sender {
    NSLog(@"%@",self.firstcontroller.currentUser.name);
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    //myposition = [error description];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
