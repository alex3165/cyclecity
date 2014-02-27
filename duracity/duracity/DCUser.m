//
//  DCUser.m
//  duracity
//
//  Created by RIEUX Alexandre on 17/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import "DCUser.h"

@implementation DCUser

static DCUser* _currentUser = nil;

+(DCUser*)currentUser{
    @synchronized([DCUser class]){
        if (!_currentUser){
            [[self alloc] init];
        }
        
		return _currentUser;
    }
    return nil;
}

+(id)alloc
{
	@synchronized([DCUser class])
	{
		NSAssert(_currentUser == nil,
                 @"Attempted to allocate a second instance of a singleton.");
		_currentUser = [super alloc];
		return _currentUser;
	}
    
	return nil;
}

- (id)initWithDictionary:(NSDictionary *)dico
{
    self = [super init];
    
    if (self) {
        
        self.iduser = [dico objectForKey:@"id"];
        self.name = [dico objectForKey:@"name"];
        self.longitude = [dico objectForKey:@"long"];
        self.latitude = [dico objectForKey:@"lat"];
    }
    
    return self;
}

- (NSDictionary*)getUserDictionary
{
    NSDictionary *userInfos;

    [userInfos initWithObjectsAndKeys:@"id", self.iduser, @"name", self.name, @"longitude", self.longitude, @"latitude", self.latitude, nil];
    return userInfos;
}

@end
