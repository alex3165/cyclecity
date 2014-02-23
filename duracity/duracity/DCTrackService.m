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

-(void)setBeginTrajectWithId:(NSString *)iduser date:(NSString *)date timeBegin:(NSString *)timeBegin success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{

    DCRequests *request = [[DCRequests alloc]init];
    [request POSTrequest:@"login.php" withParameters:@{@"id" : iduser, @"date" : date, @"timebegin" : timeBegin} success:success failure:failure];

}

-(void)setEndTrajectWithIdtraject:(NSString *)idtraject timeEnd:(NSString *)timeEnd success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{
    DCRequests *request = [[DCRequests alloc]init];
    [request POSTrequest:@"login.php" withParameters:@{@"idtraject" : idtraject, @"timeend" : timeEnd} success:success failure:failure];
}


-(void)UpdateLocvitaltWithIdtraject:(NSString *)idtraject long:(NSString *)longitude lat:(NSString *)latitude vit:(NSString *)vitesse alt:(NSString *)altitude success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure{
    DCRequests *request = [[DCRequests alloc]init];
    [request POSTrequest:@"login.php" withParameters:@{@"idtraject" : idtraject, @"long" : longitude, @"lat" : latitude, @"vitesse" : vitesse, @"altitude" : altitude} success:success failure:failure];

}


@end
