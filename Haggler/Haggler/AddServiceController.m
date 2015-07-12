//
//  AddServiceController.m
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "AddServiceController.h"
#import "AppDelegate.h"
#import "CustomGUI.h"

@interface AddServiceController ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;

@end

@implementation AddServiceController

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
    
    _header = [_customGUI defaultLabel:@"Add Service"];
    _header.frame = CGRectMake(0, 75, self.view.frame.size.width, 40);
    
    _serviceToAdd = [_customGUI defaultTextField:@"Service to add"];
    _serviceToAdd.frame = CGRectMake(80, 150, self.view.frame.size.width-160, 30);
    
    
    _addService = [_customGUI defaultButton:@"Add"];
    _addService.frame = CGRectMake(100, 200, self.view.frame.size.width-200, 30);
    [_addService addTarget:self action:@selector(postService:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _currentServices = [[UIPickerView alloc] initWithFrame:CGRectMake(100, 375, 200, 200)];
    _currentServices.delegate = self;
    _currentServices.dataSource = self;
    
    
    [self.view addSubview:_currentServices];
    [self.view addSubview:_header];
    [self.view addSubview:_serviceToAdd];
    [self.view addSubview:_addService];
    
    
}

#pragma mark pickerview

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_sharedDelegate.providerUser.services count];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSMutableDictionary *dict = [_sharedDelegate.providerUser.services objectAtIndex:row];
    NSString *str = [NSString stringWithFormat:@"%@", [dict objectForKey:@"type"]];
    return str;
}

#pragma mark services

-(void)postService:(UIButton*)sender{
    
    NSString* post = [NSString stringWithFormat:@"service[type]=%@", _serviceToAdd.text];
    NSString* method = [NSString stringWithFormat:@"?provider[id]=%@", _sharedDelegate.providerUser.unique_id];
    
    NSInteger statusCode = [_sharedDelegate.HTTPRequest postMethod:@"providers" action:@"add_service" method:method post:post auth:_sharedDelegate.providerUser.auth_token];
    

    if(statusCode == 201){
        
        UIAlertAction* OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
        }];
        
        _sharedDelegate.providerUser.services = [_sharedDelegate.HTTPRequest MethodGet:@"providers" action:@"index_services" method:[NSString stringWithFormat:@"?provider[id]=%@", _sharedDelegate.providerUser.unique_id]];
        [_sharedDelegate.HTTPRequest alert:@"message" with:@"New Service Added" buttonAction:OK];
        [_currentServices reloadComponent:0];
        
    } else {
        UIAlertAction* OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"OK");
        }];
        [_sharedDelegate.HTTPRequest alert:@"message" with:@"Service not added" buttonAction:OK];
    }
    
    
}

@end
