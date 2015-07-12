//
//  RequestViewController.h
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"

@interface RequestViewController : UIViewController

@property UILabel *userName;
@property Client *showedClient;
@property UITextView *sendMessage;
@property UITextField *messageTitle;
@property UIButton *sendButton;
@property UIButton *cancelButton;

@property NSMutableDictionary *request;


@end
