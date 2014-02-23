//
//  DCUserService.h
//  duracity
//
//  Created by RIEUX Alexandre on 23/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCUser.h"

@interface DCUserService : NSObject

-(void)createUserWithIdAndName:(NSString*)iduser name:(NSString*)name;

-(void)setUserLatAndLong:(NSString*)latitude longitude:(NSString*)longitude;

+(NSDictionary*)GetUser;

@end
