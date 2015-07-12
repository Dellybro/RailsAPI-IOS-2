//
//  InboxController.h
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface InboxController : UITableViewController

@property NSMutableDictionary *user;
@property NSObject *type;
-(id)initWithType:(NSObject*)type;


//Mutable array for messages
@property NSMutableArray *messages;
@end
