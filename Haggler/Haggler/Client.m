//
//  Client.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "Client.h"

@implementation Client


-(void)toJson:(NSMutableDictionary*)jsonDictionary{
    self.auth_token = [jsonDictionary objectForKey:@"auth_token"];
    self.password_digest = [jsonDictionary objectForKey:@"password_digest"];
    self.created_at = [jsonDictionary objectForKey:@"created_at"];
    self.user_id = [jsonDictionary objectForKey:@"id"];
    self.first_name = [jsonDictionary objectForKey:@"first_name"];
    self.last_name = [jsonDictionary objectForKey:@"last_name"];
    self.email = [jsonDictionary objectForKey:@"email"];
    self.password = [jsonDictionary objectForKey:@"password"];
    self.bio = [jsonDictionary objectForKey:@"bio"];
    self.state = [jsonDictionary objectForKey:@"state"];
    self.city = [jsonDictionary objectForKey:@"city"];
    //self.messages = [jsonDictionary objectForKey:@"messages"];
    self.address = [jsonDictionary objectForKey:@"address"];
    self.zipcode = [jsonDictionary objectForKey:@"zipcode"];
    self.unique_id = [jsonDictionary objectForKey:@"unique_id"];
}
-(NSMutableDictionary*)toDict{
    NSMutableDictionary *client = [[NSMutableDictionary alloc] init];
    [client setObject:self.auth_token forKey:@"auth_token"];
    [client setObject:self.password_digest forKey:@"password_digest"];
    [client setObject:self.created_at forKey:@"created_at"];
    [client setObject:self.user_id forKey:@"id"];
    [client setObject:self.first_name forKey:@"first_name"];
    [client setObject:self.last_name forKey:@"last_name"];
    [client setObject:self.email forKey:@"email"];
    [client setObject:self.password forKey:@"password"];
    [client setObject:self.bio forKey:@"bio"];
    [client setObject:self.state forKey:@"state"];
    [client setObject:self.city forKey:@"city"];
    [client setObject:self.address forKey:@"address"];
    [client setObject:self.zipcode forKey:@"zipcode"];
    [client setObject:self.unique_id forKey:@"unique_id"];
//    if(!(self.messages == nil)){
//        [client setObject:self.messages forKey:@"messages"];
//    }
    return client;
}
-(id)initWithJSON:(NSMutableDictionary*)jsonDictionary{
    self = [super init];
    if(self){
        //User BackendField
        self.auth_token = [jsonDictionary objectForKey:@"auth_token"];
        self.password_digest = [jsonDictionary objectForKey:@"password_digest"];
        self.created_at = [jsonDictionary objectForKey:@"created_at"];
        self.user_id = [jsonDictionary objectForKey:@"id"];
        //self.messages = [jsonDictionary objectForKey:@"messages"];
        self.unique_id = [jsonDictionary objectForKey:@"unique_id"];
        
        //User Fields
        self.first_name = [jsonDictionary objectForKey:@"first_name"];
        self.last_name = [jsonDictionary objectForKey:@"last_name"];
        self.email = [jsonDictionary objectForKey:@"email"];
        self.password = [jsonDictionary objectForKey:@"password"];
        self.bio = [jsonDictionary objectForKey:@"bio"];
        self.state = [jsonDictionary objectForKey:@"state"];
        self.city = [jsonDictionary objectForKey:@"city"];
        self.address = [jsonDictionary objectForKey:@"address"];
        self.zipcode = [jsonDictionary objectForKey:@"zipcode"];
    }
    return self;
}

@end
