//
//  DCRequests.m
//  duracity
//
//  Created by RIEUX Alexandre on 17/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCRequests.h"

@implementation DCRequests


- (id)init
{
    self = [super init];
    
    
    if (self) {
        
        NSURL *urlrequests = [NSURL URLWithString:@"http://terra.membrives.fr/app/api/"];
        self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:urlrequests];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
    }
    
    return self;
}


-(void)GETrequest:(NSString *)getstring withParameters:(NSDictionary *)params success:(DCRequestsSuccess)success failure:(DCRequestsSuccess)failure;
{
    
    [self.manager GET:getstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}



-(void) POSTrequest:(NSString *)getstring withParameters:(NSDictionary *)params success:(DCRequestsSuccess)success failure:(DCRequestsSuccess)failure;

{
    
    [self.manager POST:getstring parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success)
        {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure)
        {
            failure(error);
        }
    }];
}

@end
