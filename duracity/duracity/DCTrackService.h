//
//  DCTrackService.h
//  duracity
//
//  Created by RIEUX Alexandre on 22/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCRequests.h"

@interface DCTrackService : NSObject

-(void)loginWithLoginAndPassword:(NSString *)login password:(NSString *)password success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure;

-(void)setBeginTrajectWithId:(NSString *)iduser date:(NSString *)date timeBegin:(NSString *)timeBegin success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure;

-(void)setEndTrajectWithIdtraject:(NSString *)idtraject timeEnd:(NSString *)timeEnd success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure;

-(void)UpdateLocvitaltWithIdtraject:(NSString *)idtraject long:(NSString *)longitude lat:(NSString *)latitude vit:(NSString *)vitesse alt:(NSString *)altitude success:(DCRequestsSuccess)success failure:(DCRequestsFailure)failure;

@end
