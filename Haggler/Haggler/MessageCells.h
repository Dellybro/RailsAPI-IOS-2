//
//  MessageCells.h
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCells : UITableViewCell

@property NSMutableDictionary* note;


@property UILabel *senderAndTimeLabel;
@property UITextView *messageContentView;
@property UIImageView *bgImageView;


@end
