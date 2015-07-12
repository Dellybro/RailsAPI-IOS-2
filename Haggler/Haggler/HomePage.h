//
//  HomePage.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUp.h"

@interface HomePage : UIViewController


@property UILabel *pagetitle;

@property UIButton *login;
@property UIButton *resetPass;

@property UIBarButtonItem *signup;

@property UITextField *email;
@property UITextField *password;


@end
