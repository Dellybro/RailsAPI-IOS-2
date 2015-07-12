//
//  Message.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

-(id)initWithJson:(NSDictionary*)jsonDictionary;
@property NSMutableArray *notes;
@property NSString* provider_id;
@property NSString* client_id;
@property BOOL seen;
@property NSString* user_id;
@property NSString *messageTitle;
@property NSString *message_id;


@end
