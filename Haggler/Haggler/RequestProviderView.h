//
//  RequestProviderView.h
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"

@interface RequestProviderView : UIViewController

@property Provider *providerUser;
@property UIView *navBar;
@property UILabel *userName;
@property UIView *table;
@property UIButton *request;

@property UITextField *sendMessage;

@end
