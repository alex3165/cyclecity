//
//  DCRequests.h
//  duracity
//
//  Created by RIEUX Alexandre on 17/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^DCRequestsSuccess)();
typedef void(^DCRequestsFailure)(NSError *error);

@interface DCRequests : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

-(void) GETrequest:(NSString *)getstring withParameters:(NSDictionary *)params success:(DCRequestsSuccess)success failure:(DCRequestsSuccess)failure;

-(void) POSTrequest:(NSString *)getstring withParameters:(NSDictionary *)params success:(DCRequestsSuccess)success failure:(DCRequestsSuccess)failure;

@end
