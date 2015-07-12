//
//  InboxCells.h
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface InboxCells : UITableViewCell

@property UILabel *userID;

@property Message *messageForUser;
@property NSMutableDictionary *FromUser;


@end
