//
//  Provider.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "Provider.h"

@implementation Provider

-(id)initWithJSON:(NSMutableDictionary*)jsonDictionary{
    self = [super init];
    if(self){
        self.unique_id = [jsonDictionary objectForKey:@"unique_id"];
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
        self.services = [jsonDictionary objectForKey:@"services"];
        //self.messages = [jsonDictionary objectForKey:@"messages"];
        self.requests = [jsonDictionary objectForKey:@"requests"];
        self.client_relations = [jsonDictionary objectForKey:@"client_relations"];
        self.address = [jsonDictionary objectForKey:@"address"];
        self.zipcode = [jsonDictionary objectForKey:@"zipcode"];
    }
    return self;
}
-(NSMutableDictionary*)toDict{
    NSMutableDictionary *provider = [[NSMutableDictionary alloc] init];
    
    [provider setObject:self.auth_token forKey:@"auth_token"];
    [provider setObject:self.password_digest forKey:@"password_digest"];
    [provider setObject:self.created_at forKey:@"created_at"];
    [provider setObject:self.user_id forKey:@"id"];
    [provider setObject:self.first_name forKey:@"first_name"];
    [provider setObject:self.last_name forKey:@"last_name"];
    [provider setObject:self.email forKey:@"email"];
    [provider setObject:self.password forKey:@"password"];
    [provider setObject:self.bio forKey:@"bio"];
    [provider setObject:self.state forKey:@"state"];
    [provider setObject:self.city forKey:@"city"];
    [provider setObject:self.unique_id forKey:@"unique_id"];
    if(!(self.services == nil)){
        [provider setObject:self.services forKey:@"services"];
    }
    if(!(self.requests == nil)){
        [provider setObject:self.requests forKey:@"requests"];
    }
//    if(!(self.messages == nil)){
//        [provider setObject:self.messages forKey:@"messages"];
//    }
    if(!(self.client_relations == nil)){
        [provider setObject:self.client_relations forKey:@"client_relations"];
    }
    return provider;
}
-(void)toJson:(NSMutableDictionary*)jsonDictionary{
    self.auth_token = [jsonDictionary objectForKey:@"auth_token"];
    self.password_digest = [jsonDictionary objectForKey:@"password_digest"];
    self.created_at = [jsonDictionary objectForKey:@"created_at"];
    self.user_id = [jsonDictionary objectForKey:@"id"];
    self.unique_id = [jsonDictionary objectForKey:@"unique_id"];
    
    self.first_name = [jsonDictionary objectForKey:@"first_name"];
    self.last_name = [jsonDictionary objectForKey:@"last_name"];
    self.email = [jsonDictionary objectForKey:@"email"];
    
    self.password = [jsonDictionary objectForKey:@"password"];
    self.bio = [jsonDictionary objectForKey:@"bio"];
    self.state = [jsonDictionary objectForKey:@"state"];
    self.city = [jsonDictionary objectForKey:@"city"];
    self.services = [jsonDictionary objectForKey:@"services"];
    self.requests = [jsonDictionary objectForKey:@"requests"];
    //self.messages = [jsonDictionary objectForKey:@"messages"];
    self.client_relations = [jsonDictionary objectForKey:@"client_relations"];
}
@end
