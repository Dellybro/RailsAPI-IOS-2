//
//  RequestProviderView.m
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "RequestProviderView.h"
#import "AppDelegate.h"
#import "CustomGUI.h"

@interface RequestProviderView ()

@property CustomGUI *customGUI;
@property AppDelegate *sharedDelegate;

@end

@implementation RequestProviderView

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedDelegate = [[UIApplication sharedApplication]delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)requestService:(UIButton*)sender{
    NSString *requestTitle = [NSString stringWithFormat:@"Send request to %@", _providerUser.first_name];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:requestTitle
                                                                   message:@"Send a quick message"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {textField.placeholder = @"message";}];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *message = [[alert textFields] objectAtIndex:0];
        
        message.text.length > 0 ? (message.text) : (message.text = @"Service Request");
        
        NSString* post = [NSString stringWithFormat:@"request[request_message]=%@&request[provider_id]=%@&request[client_id]=%@", message.text, _providerUser.unique_id, _sharedDelegate.clientUser.unique_id];
        
        [_sharedDelegate.HTTPRequest postMethod:@"clients" action:@"createRequest" method:nil post:post auth:nil];
        [_sharedDelegate.HTTPRequest alert:@"message" with:nil buttonAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
        
    }];
    
    [alert addAction:action];
    
    [_sharedDelegate.navController presentViewController:alert animated:YES completion:nil];
}
-(void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _navBar = [_customGUI CustomConsumerNavBar];
    
    _userName = [_customGUI defaultLabel:_providerUser.first_name];
    _userName.frame = CGRectMake(0, 90, self.view.frame.size.width, 25);
    
    _request = [_customGUI defaultMenuButton:@"Request Service"];
    _request.frame = CGRectMake((self.view.frame.size.width/2)-60, 20, 120, 30);
    [_request addTarget:self action:@selector(requestService:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_request];
    [self.view addSubview:_userName];
    [self.view addSubview:_navBar];
    [self.view sendSubviewToBack:_navBar];
}



@end
