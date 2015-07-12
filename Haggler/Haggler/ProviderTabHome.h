//
//  ProviderTabHome.h
//  Haggler
//
//  Created by Travis Delly on 7/10/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestsTableView.h"
#import "AddServiceController.h"
#import "InboxController.h"
#import "ProviderHomeView.h"

@interface ProviderTabHome : UITabBarController

@property ProviderHomeView *homeView;
@property RequestsTableView *requestsController;
@property AddServiceController *addServicesController;
@property InboxController *inboxController;

@end
