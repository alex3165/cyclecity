//
//  DCViewController.h
//  duracity
//
//  Created by RIEUX Alexandre on 06/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFNetworking.h"
//#import <CoreLocation/CoreLocation.h>
//#import "DCLogViewController.h"

#import "DCUser.h"
//#import "DCRequests.h"
#import "DCTrackService.h"

@interface DCViewController : UIViewController

@property (nonatomic, strong) DCTrackService *trackService;
@property (weak, nonatomic) IBOutlet UIButton *traceme;

@end