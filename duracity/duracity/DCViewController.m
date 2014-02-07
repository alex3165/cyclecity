//
//  DCViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 06/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCViewController.h"

@interface DCViewController ()
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
//@property(weak,nonatomic) NSMutableDictionary *positions;
@end

@implementation DCViewController

    //NSDictionary *dico;
    //NSMutableDictionary *positions = [NSMutableDictionary dico];
    NSString * mylatitude;
    NSString * mylongitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)request:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys: mylatitude, @"lat", mylongitude, @"long", nil];
    [manager POST:@"localhost:8888/app.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    mylatitude = [NSString localizedStringWithFormat:@"%f",coordinate.latitude];
    mylongitude = [NSString localizedStringWithFormat:@"%f",coordinate.longitude];
    
    
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
