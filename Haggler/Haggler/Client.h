//
//  Client.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject
@property NSNumber* unique_id;
@property NSString* auth_token;
@property NSNumber* user_id;
@property NSString* first_name;
@property NSString* last_name;
@property NSString* email;
@property NSString* password;
@property NSString* bio;
@property NSDate* created_at;
@property NSDate* updated_at;
@property NSString* password_digest;
@property NSString* state;
@property NSString* city;
@property NSString* address;
@property NSNumber* zipcode;
//@property NSMutableArray* messages;


-(void)toJson:(NSMutableDictionary*)jsonDictionary;
-(NSMutableDictionary*)toDict;
-(id)initWithJSON:(NSMutableDictionary*)jsonDictionary;

@end
