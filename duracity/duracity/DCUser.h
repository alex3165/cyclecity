//
//  DCUser.h
//  duracity
//
//  Created by RIEUX Alexandre on 17/02/2014.
//  Copyright (c) 2014 RIEUX Alexandre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCUser : NSObject


@property (nonatomic,strong) NSString *iduser;
@property (nonatomic,strong) NSString *idTraject;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;

- (void)fillWithDictionary:(NSDictionary *)dico;

-(void)setIdTraject:(NSString *)idTraject;

- (NSString*)getUserId;
- (NSString*)getUserName;
- (NSString*)getUserLong;
- (NSString*)getUserLat;

+(DCUser*)currentUser;


@end
