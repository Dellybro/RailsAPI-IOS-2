//
//  Message.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "Message.h"

@implementation Message

-(id)initWithJson:(NSDictionary*)jsonDictionary{
    self = [super init];
    if (self){
        _message_id = [jsonDictionary objectForKey:@"id"];
        _notes = [jsonDictionary objectForKey:@"notes"];
        _provider_id = [jsonDictionary objectForKey:@"provider_id"];
        _client_id = [jsonDictionary objectForKey:@"client_id"];
        _messageTitle = [jsonDictionary objectForKey:@"messageTitle"];
    }
    return self;
}

-(NSMutableDictionary*)toDict{
    NSMutableDictionary *message;
    
    if(self.notes != nil){
        [message setObject:self.notes forKey:@"notes"];
    }
    [message setObject:self.message_id forKey:@"id"];
    [message setObject:self.provider_id forKey:@"provider_id"];
    [message setObject:self.client_id forKey:@"client_id"];
    [message setObject:self.messageTitle forKey:@"messageTitle"];
    
    return message;
}

@end
