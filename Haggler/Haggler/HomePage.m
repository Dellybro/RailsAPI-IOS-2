//
//  HomePage.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "HomePage.h"
#import "AppDelegate.h"
#import "CustomGUI.h"
#import "ProviderHomeView.h"
#import "ClientHomeView.h"
@interface HomePage ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;
@property (nonatomic) float vspacing;
@property (nonatomic) float hspacing;
@property (strong, nonatomic) NSMutableArray *constraints;
@end

@implementation HomePage

-(void)viewDidAppear:(BOOL)animated{
    self.email.text = @"";
    self.password.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Make Custom Objects
    self.view.backgroundColor = [UIColor whiteColor];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    
    //Do setups
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)gotoSignup:(UIBarButtonItem*)sender{
    SignUp *signupController = [[SignUp alloc] init];
    
    [_sharedDelegate.navController pushViewController:signupController animated:YES];
    
}
-(void)signin:(UIButton*)sender{
    
    id loginProvider = [_sharedDelegate.HTTPRequest signin:_email.text for:_password.text fortype:@"providers"];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    if(loginProvider == 0){
        id loginClient = [_sharedDelegate.HTTPRequest signin:_email.text for:_password.text fortype:@"clients"];
        if(loginClient == 0){
            [_sharedDelegate.HTTPRequest alert:@"message" with:@"Try again" buttonAction:cancel];
            //final failure
        } else {
            //login consumer
            
            ClientHomeView *ClientController = [[ClientHomeView alloc] init];
            NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:ClientController, nil];
            _sharedDelegate.clientUser = [[Client alloc] initWithJSON:loginClient];
            [self.navigationController setViewControllers:controllers animated:YES];
        }
    } else {
        _sharedDelegate.providerUser = [[Provider alloc] initWithJSON:loginProvider];
        
        ProviderHomeView *providerController = [[ProviderHomeView alloc] init];
        NSMutableArray *controllers = [[NSMutableArray alloc] initWithObjects:providerController, nil];
        [self.navigationController setViewControllers:controllers animated:YES];
    }

    
}
-(void)dismissKeyboard:(UITapGestureRecognizer*)sender{
    for (id textfield in self.view.subviews){
        if ([textfield isFirstResponder]){
            [textfield resignFirstResponder];
        }
    }
}
-(void)setup{
    
    _pagetitle = [_customGUI defaultLabel:@"Login"];
    _pagetitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    _email = [_customGUI defaultTextField:@"email"];
    _email.translatesAutoresizingMaskIntoConstraints = NO;
    
    _password = [_customGUI defaultTextField:@"password"];
    _password.secureTextEntry = YES;
    _password.translatesAutoresizingMaskIntoConstraints = NO;
    
    _login = [_customGUI defaultButton:@"login"];
    [_login addTarget:self action:@selector(signin:) forControlEvents:UIControlEventTouchUpInside];
    _login.translatesAutoresizingMaskIntoConstraints = NO;
    
    _resetPass = [_customGUI standardButton:@"reset password"];
    _resetPass.translatesAutoresizingMaskIntoConstraints = NO;
    
    _signup = [[UIBarButtonItem alloc] initWithTitle:@"SignUp" style:UIBarButtonItemStylePlain target:self action:@selector(gotoSignup:)];
    
    UITapGestureRecognizer *releaseKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    
    [self.view addGestureRecognizer:releaseKeyboard];
    self.navigationItem.rightBarButtonItem = _signup;
    [self.view addSubview:_resetPass];
    [self.view addSubview:_login];
    [self.view addSubview:_pagetitle];
    [self.view addSubview:_password];
    [self.view addSubview:_email];
    
    
    //constraints
    [self landscapeCheck];
    [self addConstraints];
    
}
-(void)landscapeCheck{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        _vspacing = 25.0;
        _hspacing = 150.0;
    } else {
        _vspacing = 50.0;
        _hspacing = 70.0;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self landscapeCheck];
    
    if (_constraints) {
        [self.view removeConstraints:(NSArray *)_constraints];
    }
    [self addConstraints];
}

-(void)addConstraints {
    id topLayoutGuide = self.topLayoutGuide;
    _constraints = [[NSMutableArray alloc] init];
    NSDictionary *variablesDictionary = NSDictionaryOfVariableBindings(_resetPass, _login, _pagetitle, _password, _email, topLayoutGuide);
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(hspacing)-[_pagetitle]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(hspacing)-[_email]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(hspacing)-[_password]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(hspacing)-[_login]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(hspacing)-[_resetPass]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_pagetitle(40)]-(vspacing)-[_email(30)]-(vspacing)-[_password(==_email)]-(vspacing)-[_login(40)]-(vspacing)-[_resetPass(20)]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    [self.view addConstraints:(NSArray *)_constraints];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

@end
