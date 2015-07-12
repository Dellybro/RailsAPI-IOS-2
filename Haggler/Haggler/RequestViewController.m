//
//  RequestViewController.m
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "RequestViewController.h"
#import "AppDelegate.h"
#import "CustomGUI.h"

@interface RequestViewController ()

@property CustomGUI *customGUI;
@property AppDelegate *sharedDelegate;

@property float hspacing;
@property float vspacing;
@property NSMutableArray *constraints;

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customGUI = [[CustomGUI alloc] init];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    _userName = [_customGUI defaultLabel:[NSString stringWithFormat:@"To: %@", _showedClient.first_name]];
    _userName.translatesAutoresizingMaskIntoConstraints = NO;
  
    _messageTitle = [_customGUI defaultTextField:[_request objectForKey:@"request_message"]];
    _messageTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    _sendMessage = [_customGUI defaultTextView];
    _sendMessage.translatesAutoresizingMaskIntoConstraints = NO;
    _sendMessage.font = [UIFont systemFontOfSize:18];
    _sendMessage.text = @"Hello thanks for contacting me.";
    
    _sendButton = [_customGUI defaultButton:@"Confirm and add"];
    _sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_sendButton addTarget:self action:@selector(sendResponse:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancelButton = [_customGUI defaultButton:@"Deny"];
    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:_messageTitle];
    [self.view addSubview:_sendButton];
    [self.view addSubview:_cancelButton];
    [self.view addSubview:_sendMessage];
    [self.view addSubview:_userName];
    
    //constraints
    [self landscapeCheck];
    [self addConstraint];
    
}
-(void)landscapeCheck{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        _vspacing = 25.0;
        _hspacing = 70.0;
    } else {
        _vspacing = 50.0;
        _hspacing = 35.0;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self landscapeCheck];
    
    if (_constraints) {
        [self.view removeConstraints:(NSArray *)_constraints];
    }
    [self addConstraint];
}

-(void)addConstraint{
    id topLayoutGuide = self.topLayoutGuide;
    _constraints = [[NSMutableArray alloc] init];
    NSDictionary *variablesDictionary = NSDictionaryOfVariableBindings(_messageTitle, _sendButton, _cancelButton, _sendMessage, _userName, topLayoutGuide);
    
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_userName]|" options:0 metrics:nil views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_messageTitle]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_sendMessage]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_sendButton]-(hspacing)-[_cancelButton(==_sendButton)]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_userName]-(vspacing)-[_messageTitle(30.0)]-(vspacing)-[_sendMessage(100)]-(vspacing)-[_sendButton]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_userName]-(vspacing)-[_messageTitle]-(vspacing)-[_sendMessage(100)]-(vspacing)-[_cancelButton]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    
    [self.view addConstraints:_constraints];
    
}

-(void)sendResponse:(UIButton*)sender{
    NSString* TitleforMessage;
    [_messageTitle.text isEqual:@""] ? (TitleforMessage = _messageTitle.placeholder) : (TitleforMessage = _messageTitle.text);
    NSString* postMessage = [NSString stringWithFormat:@"note[user_unique_id]=%@&note[message]=%@&message[user_id]=%@&message[messageTitle]=%@&message[provider_id]=%@&message[client_id]=%@&request[client_unique]=%@", _sharedDelegate.providerUser.unique_id, _sendMessage.text, _sharedDelegate.providerUser.user_id, TitleforMessage,_sharedDelegate.providerUser.user_id, _showedClient.user_id, _showedClient.unique_id];
    
    
    NSInteger status = [_sharedDelegate.HTTPRequest postMethod:@"providers" action:@"acceptRequest" method:nil post:postMessage auth:nil];
    
    if (status == 201){
        [self sendAlert:@"Client accepted"];
    } else {
        [self sendAlert:@"Error"];
    }
    
}
-(void)sendAlert:(NSString*)message{
    [_sharedDelegate.HTTPRequest alert:@"message" with:message buttonAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if([message isEqualToString:@"Error"]){
            //do not
        } else {
            NSMutableDictionary *reloadUser = [_sharedDelegate.HTTPRequest MethodGet:@"users" action:@"show_with_unique" method:[NSString stringWithFormat:@"?provider[unique_id]=%@", _sharedDelegate.providerUser.unique_id]];
            _sharedDelegate.providerUser = [[Provider alloc] initWithJSON:reloadUser];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }]];
}


@end
