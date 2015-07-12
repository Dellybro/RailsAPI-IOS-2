//
//  SignUp.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "SignUp.h"
#import "AppDelegate.h"
#import "CustomGUI.h"

@interface SignUp ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;


@property (nonatomic) float vspacing;
@property (nonatomic) float hspacing;
@property (strong, nonatomic) NSMutableArray *constraints;

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    //Setups
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectState:(UIButton*)sender{
    _stateField.text = _customGUI.stateString;
    [_stateField reloadInputViews];
    [_stateField resignFirstResponder];
}
-(void)createUser:(UIButton*)sender{
    
    
    if([_passwordField.text isEqualToString:_confirmPassField.text]){
        NSString *post;
        if(_type.isOn){
            post = [NSString stringWithFormat:@"provider[first_name]=%@&provider[last_name]=%@&provider[email]=%@&provider[bio]=%@&provider[state]=%@&provider[city]=%@&provider[zipcode]=%@&provider[address]=%@&provider[password]=%@", _name.text, _last.text, _emailField.text, _bio.text, _stateField.text, _city.text, _zipcode.text, _address.text, _passwordField.text];
        } else {
            post = [NSString stringWithFormat:@"client[first_name]=%@&client[last_name]=%@&client[email]=%@&client[bio]=%@&client[state]=%@&client[city]=%@&client[zipcode]=%@&client[address]=%@&client[password]=%@", _name.text, _last.text, _emailField.text, _bio.text, _stateField.text, _city.text, _zipcode.text, _address.text, _passwordField.text];
        }//After ceck type is on
        
        NSInteger statusCode = [_sharedDelegate.HTTPRequest postMethod:@"users" action:@"create" method:nil post:post auth:nil];
        
        if(statusCode == 201){
            [_sharedDelegate.HTTPRequest alert:@"message" with:@"Success" buttonAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [_sharedDelegate.navController popToRootViewControllerAnimated:YES];
            }]];
        } else {
            [_sharedDelegate.HTTPRequest alert:@"message" with:@"Unsuccess" buttonAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }]];
        }
    } else {
        
    }
    
}




#pragma mark setup/keyboard operations
-(void)setup{
    
    _controllerTitle = [_customGUI defaultLabel:@"Create New Profile"];
    _controllerTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    _name = [_customGUI defaultTextField:@"First Name"];
    _name.translatesAutoresizingMaskIntoConstraints = NO;
    
    _last = [_customGUI defaultTextField:@"Last Name"];
    _last.translatesAutoresizingMaskIntoConstraints = NO;
    
    _emailField = [_customGUI defaultTextField:@"email"];
    _emailField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _passwordField = [_customGUI defaultTextField:@"password"];
    _passwordField.secureTextEntry = YES;
    _passwordField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _confirmPassField = [_customGUI defaultTextField:@"confirm password"];
    _confirmPassField.secureTextEntry = YES;
    _confirmPassField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _bioLabel = [_customGUI defaultLabel:@"Tell us about yourself"];
    _bioLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    _bio = _customGUI.defaultTextView;
    _bio.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    //state picker stuff
    _picker = _customGUI.statePickerKeyboard;
    _stateField = [_customGUI defaultTextField:@"State select"];
    [_stateField setInputView:_picker];
    [_customGUI.doubletap addTarget:self action:@selector(selectState:)];
    _stateField.tintColor = [UIColor whiteColor];
    _stateField.translatesAutoresizingMaskIntoConstraints = NO;
    
    _city = [_customGUI defaultTextField:@"Enter City name"];
    _city.translatesAutoresizingMaskIntoConstraints = NO;
    
    _address = [_customGUI defaultTextField:@"address"];
    _address.translatesAutoresizingMaskIntoConstraints = NO;
    
    _zipcode = [_customGUI defaultTextField:@"zipcode"];
    [_zipcode setKeyboardType:UIKeyboardTypeNumberPad];
    _zipcode.translatesAutoresizingMaskIntoConstraints = NO;
    
    _type = [[UISwitch alloc] initWithFrame:CGRectZero];
    _type.translatesAutoresizingMaskIntoConstraints = NO;
    
    _typeText = [[UILabel alloc] initWithFrame:CGRectZero];
    _typeText.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:10];
    _typeText.text = @"Swipe right to create provider profile";
    _typeText.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _save = [_customGUI defaultButton:@"Ceate Profile!"];
    [_save addTarget:self action:@selector(createUser:) forControlEvents:UIControlEventTouchUpInside];
    _save.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_address];
    [self.view addSubview:_last];
    [self.view addSubview:_zipcode];
    [self.view addSubview:_stateField];
    [self.view addSubview:_bioLabel];
    [self.view addSubview:_city];
    [self.view addSubview:_typeText];
    [self.view addSubview:_type];
    [self.view addSubview:_confirmPassField];
    [self.view addSubview:_name];
    [self.view addSubview:_save];
    [self.view addSubview:_bio];
    [self.view addSubview:_emailField];
    [self.view addSubview:_passwordField];
    [self.view addSubview:_controllerTitle];
    
    //_cancelKeyboards = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    
    //[self.view addGestureRecognizer:_cancelKeyboards];
    //[self setupKeyboardActivity];
    [self landscapeCheck];
    [self addConstraints];
    
    
}

-(void)setupKeyboardActivity{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:@"UIKeyboardDidHideNotification" object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)note{
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y-kbSize.height;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.frame = frame;
    }];
    
}
- (void) keyboardDidHide:(NSNotification *)note {
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.frame = frame;
    }];
}
-(void)dismissKeyboard:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}
-(void)addConstraints{
    id topLayoutGuide = self.topLayoutGuide;
    _constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *variablesDictionary = NSDictionaryOfVariableBindings(_name, _last, _emailField, _passwordField, _confirmPassField, _bio, _stateField, _city, _address, _zipcode,_type,_typeText,_save,_controllerTitle, _bioLabel, topLayoutGuide);
    
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_controllerTitle]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_name]-(hspacing)-[_last(==_name)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_emailField]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_passwordField]-(hspacing)-[_confirmPassField(==_passwordField)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_bioLabel]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_bio(==_controllerTitle)]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_stateField]-(hspacing)-[_city(==_stateField)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_address]-(hspacing)-[_zipcode(==_address)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_type]-(hspacing)-[_typeText]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_save]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-[_controllerTitle]-(vspacing)-[_name]-(vspacing)-[_emailField]-(vspacing)-[_passwordField]-(vspacing)-[_bioLabel]-(vspacing)-[_bio(50.0)]-(vspacing)-[_stateField]-(vspacing)-[_address]-(vspacing)-[_type]-(vspacing)-[_save]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-[_controllerTitle]-(vspacing)-[_last]-(vspacing)-[_emailField]-(vspacing)-[_confirmPassField]-(vspacing)-[_bioLabel]-(vspacing)-[_bio(50.0)]-(vspacing)-[_city]-(vspacing)-[_zipcode]-(vspacing)-[_typeText]-(vspacing)-[_save]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    
    [self.view addConstraints:(NSArray *)_constraints];

}
-(void)landscapeCheck{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        _vspacing = 5.5;
        _hspacing = 70.0;
    } else {
        _vspacing = 25.0;
        _hspacing = 25.0;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self landscapeCheck];
    
    if (_constraints) {
        [self.view removeConstraints:(NSArray *)_constraints];
    }
    [self addConstraints];
}

@end
