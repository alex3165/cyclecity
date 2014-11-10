//
//  ViewController.m
//  cyclecity
//
//  Created by RIEUX Alexandre on 05/10/2014.
//  Copyright (c) 2014 ___alexprod___. All rights reserved.
//

#import "ViewController.h"
#import <Mapbox-iOS-SDK/Mapbox.h>

#define kMapboxID "alex3165.iaca27i5"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RMMapboxSource *onlineSource = [[RMMapboxSource alloc] initWithMapID:@kMapboxID];
    RMMapView *myMap = [[RMMapView alloc] initWithFrame:self.view.bounds andTilesource:onlineSource];
    
    myMap.zoom = 12;
    CLLocationDegrees lat = 48.117266;
    CLLocationDegrees longi = -1.6777925999999752;
    
    myMap.centerCoordinate = CLLocationCoordinate2DMake(lat, longi);
    
    myMap.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:myMap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
