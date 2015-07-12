//
//  AppDelegate.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Provider.h"
#import "HTTPHelper.h"
#import "Client.h"
#import "HomePage.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

-(void)loggedIn;

@property HTTPHelper *HTTPRequest;
@property (strong, nonatomic) UIWindow *window;
@property UINavigationController *navController;

@property HomePage *rootView;

@property (nonatomic, strong) Provider *providerUser;
@property (nonatomic, strong) Client *clientUser;

@property NSMutableArray *resetStack;
@property NSMutableArray *listOfStates;
@property NSMutableArray *listofProviders;
@property NSMutableArray *listofClients;

@end

