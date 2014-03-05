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
    _clickCounter = YES;
    self.userLoc = [[DCLocationService alloc] init];
    
}


- (IBAction)requestEvent:(id)sender {
    
    NSString *idUser = [[DCUser currentUser] getUserId];
    
    /******** Check how times user pressed requestEvent **********/
    
    if (_clickCounter) {
        [self.trackService setBeginTrajectWithId:idUser success:^(NSDictionary *datas){
            
            [[DCUser currentUser] setIdTraject:[datas objectForKey:@"idtraject"]];
            _clickCounter = NO;
            //self.traceme.backgroundColor = [UIColor greenColor];
            
            NSLog(@"%@",datas);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        NSString *idtraject = [[DCUser currentUser] idTraject];
        [self.trackService setEndTrajectWithIdtraject:idtraject success:^(NSDictionary *datas){
            // Change color button
           _clickCounter = YES;
            NSLog(@"%@",datas);
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    /***********************************************************/
    
    
}

@end
