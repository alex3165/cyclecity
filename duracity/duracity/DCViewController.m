//
//  DCViewController.m
//  duracity
//
//  Created by RIEUX Alexandre on 06/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCViewController.h"

@interface DCViewController ()
    @property (nonatomic, assign) BOOL clickCounter;
    @property (nonatomic,weak) NSMutableArray *successDatas;
    @property (nonatomic,retain) NSDateFormatter *formatter;
    //@property (nonatomic,weak) NSCalendar *calendar;
    //@property (nonatomic,weak) NSDateComponents *components;
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
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.formatter = [[NSDateFormatter alloc] init];
    self.trackService = [[DCTrackService alloc] init];
    
    self.successDatas = [NSMutableArray array];

    _clickCounter = YES;
    
    [self.tableInfos numberOfRowsInSection:4];
    [self.formatter setDateFormat:@"hh:mm:ss a"];

}


- (IBAction)requestEvent:(id)sender {
    
    NSString *idUser = [[DCUser currentUser] iduser];
    
    /******** Check how times user pressed requestEvent **********/
    
    if (_clickCounter) {
        
        [self.trackService setBeginTrajectWithId:idUser success:^(NSDictionary *datas){
            
            [[DCUser currentUser] setIdTraject:[datas objectForKey:@"idtraject"]];
            _clickCounter = NO;
            
            self.traceme.backgroundColor = [UIColor greenColor];
            
            if ([CLLocationManager locationServicesEnabled])
            {
                self.locationManager.delegate = self;
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                self.locationManager.distanceFilter = 100.0f;
                [self.locationManager startUpdatingLocation];
            }
            NSLog(@"%@",datas);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }else{
        NSString *idtraject = [[DCUser currentUser] idTraject];
        
        [self.trackService setEndTrajectWithIdtraject:idtraject success:^(NSDictionary *datas){
            _clickCounter = YES;
            self.traceme.backgroundColor = [UIColor redColor];

            NSLog(@"%@",datas);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    /***********************************************************/
    
    
}



/****************  Delegate location manager  ************************/

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    
    CLLocationCoordinate2D coordinate = [newLocation coordinate];
    CLLocationSpeed userspeed = [newLocation speed];
    
    [[DCUser currentUser] setLatitude:[[NSNumber numberWithDouble:coordinate.latitude] stringValue]];
    [[DCUser currentUser] setLongitude:[[NSNumber numberWithDouble:coordinate.longitude] stringValue]];
    [[DCUser currentUser] setVitesse:[[NSNumber numberWithDouble:userspeed] stringValue]];
    

    
    
    [self SendNewLocationOnServer];
    
}
/*****************************************************************/


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    // afficher : impossible d'avoir accès à la localisation
}

-(void)SendNewLocationOnServer{
    

    NSDictionary *userinfos = [[DCUser currentUser] getUserForUpdateLoc];
    [self.trackService UpdateLocvitaltWithIdtraject:[userinfos objectForKey:@"idTraject"] long:[userinfos objectForKey:@"longitude"] lat:[userinfos objectForKey:@"latitude"] vit:[userinfos objectForKey:@"vitesse"] success:^(NSDictionary *datas){
        
        //self.calendar = [NSCalendar currentCalendar];
        //self.components = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self.date];
        
        NSString *successObject = [NSString localizedStringWithFormat:@"%@ at %@",[datas objectForKey:@"status"],[self.formatter stringFromDate:[NSDate date]]];
        
        [self.successDatas addObject:successObject];

        [self.tableInfos beginUpdates];
        [self.tableInfos insertRowsAtIndexPaths:self.successDatas withRowAnimation:UITableViewRowAnimationFade];
        [self.tableInfos endUpdates];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end