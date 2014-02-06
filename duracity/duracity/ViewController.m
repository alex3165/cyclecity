//
//  ViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 02/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
@end

@implementation ViewController


NSString * myposition;
NSString * mylatitude;
NSString * mylongitude;

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 100.0f;
        [locationManager startUpdatingLocation];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valider:(id)sender {
    
}




- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
        fromLocation:(CLLocation *)oldLocation
{
    
    //[newLocation initWithLatitude:40.333 longitude:-1.2];
    myposition = [newLocation description];
    
    CLLocationCoordinate2D coordinate = [newLocation coordinate];
    mylatitude = [NSString localizedStringWithFormat:@"%f",coordinate.latitude];
    mylongitude = [NSString localizedStringWithFormat:@"%f",coordinate.longitude];
    NSDictionary *parameters = @{@"lat" : @"%@"};
    NSLog(@"%@  %@", mylatitude, mylongitude);
    //NSDictionary *positions = [NSDictionary: coordinate.latitude, coordinate.longitude, nil];
    //mylatitude = coordinate.latitude;
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    myposition = [error description];
}



@end
