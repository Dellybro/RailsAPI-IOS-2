//
//  ProviderTabHome.m
//  Haggler
//
//  Created by Travis Delly on 7/10/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "ProviderTabHome.h"
#import "AppDelegate.h"

@interface ProviderTabHome ()

@property AppDelegate *sharedDelegate;

@end

@implementation ProviderTabHome

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    _homeView = [[ProviderHomeView alloc] init];
    _addServicesController = [[AddServiceController alloc] init];
    _requestsController = [[RequestsTableView alloc] init];
    _inboxController = [[InboxController alloc] initWithType:[[Provider alloc]init]];
    
    [self setupHome];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:_homeView];
    [tabViewControllers addObject:_addServicesController];
    [tabViewControllers addObject:_requestsController];
    [tabViewControllers addObject:_inboxController];
    //Set view controllers to tabController
    [self setViewControllers:tabViewControllers];
    
    _homeView.tabBarItem =
    [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:0];
    _addServicesController.tabBarItem =
    [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemTopRated tag:1];
    _requestsController.tabBarItem =
    [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:2];
    _inboxController.tabBarItem =
    [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:3];
}

//Selected stuff
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if (item.tag == 0){
        [self setupHome];
    }else if(item.tag == 1){
        [self setupServices];
    } else if (item.tag == 2){
        [self setupRequests];
    } else if (item.tag == 3){
        [self setupInbox];
    }
}

//setup Stuff
-(void)setupHome{
    self.navigationController.navigationBarHidden = YES;
}
-(void)setupServices{
    self.navigationController.navigationBarHidden = YES;
}
-(void)setupRequests{
    self.navigationController.navigationBarHidden = YES;
}
-(void)setupInbox{
    self.navigationController.navigationBarHidden = YES;
}

@end
