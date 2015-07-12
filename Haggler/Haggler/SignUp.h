//
//  SignUp.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController <UITextFieldDelegate>


@property UILabel *bioLabel;
@property UILabel *controllerTitle;
@property UITextField *emailField;
@property UITextField *passwordField;
@property UITextField *confirmPassField;
@property UITextField *name;
@property UITextField *last;
@property UITextView *bio;
@property UIButton *save;
@property UITextField *city;
@property UISwitch *type;
@property UILabel *typeText;
@property UITapGestureRecognizer *cancelKeyboards;
@property UITextField *stateField;
@property UIView *picker;

//newFields

@property UITextField *address;
@property UITextField *zipcode;

@end
