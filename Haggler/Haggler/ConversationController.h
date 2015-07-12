//
//  ConversationController.h
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@interface ConversationController : UITableViewController

@property Message *messages;
@property NSMutableDictionary *user;
@property NSObject *type;
@property NSInteger messageNumber;

-(id)initWithType:(NSObject*)type;

@property UIView *headerView;

//Send message stuff

@property UILabel *header;
@property UITextView* messageView;
@property UIButton* send;

@end
