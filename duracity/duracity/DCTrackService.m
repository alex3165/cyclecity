//
//  DCTrackService.m
//  duracity
//
//  Created by RIEUX Alexandre on 22/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCTrackService.h"
//#import "DCRequests.h"

@implementation DCTrackService

-(void)loginWithLoginAndPassword:(NSString *)login password:(NSString *)password success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{

    DCRequests *request = [[DCRequests alloc]init];
    
    [request POSTrequest:@"login.php" withParameters:@{@"login" : login, @"mdp" : password} success:success failure:failure];
    
}

-(void)setBeginTrajectWithId:(NSString *)iduser success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{

    DCRequests *request = [[DCRequests alloc]init];
    
    [request POSTrequest:@"traject.php" withParameters:@{@"id" : iduser} success:success failure:failure];

}

-(void)setEndTrajectWithIdtraject:(NSString *)idtraject success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{
    
    DCRequests *request = [[DCRequests alloc]init];
    
    [request POSTrequest:@"traject.php" withParameters:@{@"idtraject" : idtraject} success:success failure:failure];
}


-(void)UpdateLocvitaltWithIdtraject:(NSString *)idtraject long:(NSString *)longitude lat:(NSString *)latitude vit:(NSString *)vitesse success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{
    
    DCRequests *request = [[DCRequests alloc]init];
    
    [request POSTrequest:@"location.php" withParameters:@{@"idtraject" : idtraject, @"long" : longitude, @"lat" : latitude, @"vitesse" : vitesse} success:success failure:failure];

}


@end