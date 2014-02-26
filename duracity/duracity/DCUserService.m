//
//  DCUserService.m
//  duracity
//
//  Created by RIEUX Alexandre on 23/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCUserService.h"

@implementation DCUserService

DCUser* user;

-(void)createUserWithIdAndName:(NSString*)iduser name:(NSString*)name{
    
    NSDictionary *userdico =[[NSDictionary alloc] initWithObjectsAndKeys:@"id",iduser, @"name",name, nil];
    
    user = [[DCUser alloc] initWithDictionary:userdico];
    
}

-(void)setUserLatAndLong:(NSString*)latitude longitude:(NSString*)longitude{

// Méthode à remplir !!

}


-(NSDictionary*)getUser{
    
    return [user getUserDictionary];

}


@end
