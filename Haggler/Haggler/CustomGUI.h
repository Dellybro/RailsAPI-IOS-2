//
//  CustomGUI.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface CustomGUI : NSObject <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

-(UIButton*)standardButton:(NSString*)text;
-(UITextView*)defaultTextView;
-(UIView*)statePickerKeyboard;
-(UITextField*)defaultTextField:(NSString*)placeHolder;
-(UIButton*)defaultButton:(NSString*)text;
-(UILabel*)defaultLabel:(NSString*)text;
-(UIView*)defaultView;
-(UIView*)backgroundView;
-(UIView*)CustomConsumerNavBar;
-(UIButton*)defaultMenuButton:(NSString*)title;
-(UITextField*)stateField:(NSString*)placeHolder;
-(UITextField*)defaultTextFieldWithText:(NSString*)text;
@property UITapGestureRecognizer *doubletap;
@property UIView *stateKeyboard;
@property UIPickerView* statePicker;
@property NSString* stateString;

@end