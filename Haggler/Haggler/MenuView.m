//
//  MenuView.m
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomGUI.h"
#import "MenuView.h"
#import "Provider.h"
#import "Client.h"
#import "RequestsTableView.h"
#import "InboxController.h"
#import "AddServiceController.h"
#import "SearchViewController.h"

@interface MenuView ()

@property InboxController *inboxController;
@property RequestsTableView* requestsController;
@property AddServiceController *serviceController;
@property SearchViewController *searchViewClient;
@property AppDelegate* sharedDelegate;
@property CustomGUI* customGUI;

@end

@implementation MenuView

-(id)initWithType:(NSObject*)type{
    self = [super init];
    if(self){
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
    
    
    //check for provider/client
    if([_type class] == [Provider class]){
        NSLog(@"Provider");
        [self setupProvider];
    }
    if([_type class] == [Client class]){
        NSLog(@"Client");
        [self setupClient];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//Navigation Tools:

-(void)stackit:(UIViewController*)newController{
    if(_controllers.count > 1){
        [_controllers removeLastObject];
        [_controllers addObject:newController];
        [_sharedDelegate.navController setViewControllers:_controllers animated:YES];
    } else {
        [_sharedDelegate.navController pushViewController:newController animated:YES];
    }
}

//Provider Button Actions
-(void)gotoRequests:(UIButton*)sender{
    [self stackit:_requestsController];
}

-(void)gotoInboxProvider:(UIButton*)sender{
    _inboxController = [[InboxController alloc] initWithType:[[Provider alloc] init]];
    [self stackit:_inboxController];
}
-(void)gotoServices:(UIButton*)sender{
    [self stackit:_serviceController];
}
//Client Button Actions
-(void)gotoInboxClient:(UIButton*)sender{
    _inboxController = [[InboxController alloc] initWithType:[[Client alloc] init]];
    [self stackit:_inboxController];
}
-(void)gotoSearchViewClient:(UIButton*)sender{
    [self stackit:_searchViewClient];
}

//Shared Buttons Actions
-(void)gotoHome:(UIButton *)sender{
    [_sharedDelegate.navController popToRootViewControllerAnimated:YES];
}
-(void)gotoLogout:(UIButton *)sender{
    _sharedDelegate.providerUser = nil;
    _sharedDelegate.clientUser = nil;
    [_sharedDelegate loggedIn];
    
}

//setups
-(void)setup{
    UILabel *menuTitle = [_customGUI defaultLabel:@"Menu"];
    menuTitle.frame = CGRectMake(0, 50, self.view.frame.size.width, 40);
    
    
    UIButton *HomeButton = [_customGUI defaultMenuButton:@"Home"];
    HomeButton.frame = CGRectMake(70, 100, (self.view.frame.size.width-140), 40);
    [HomeButton addTarget:self action:@selector(gotoHome:) forControlEvents:UIControlEventTouchUpInside];
    
    _inbox = [_customGUI defaultMenuButton:@"Inbox"];
    _inbox.frame = CGRectMake(70, 150, (self.view.frame.size.width-140), 40);
    
    _logout = [_customGUI defaultMenuButton:@"Logout"];
    [_logout addTarget:self action:@selector(gotoLogout:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_inbox];
    [self.view addSubview:_logout];
    [self.view addSubview:menuTitle];
    [self.view addSubview:HomeButton];
    
    
    _serviceController = [[AddServiceController alloc] init];
    _requestsController = [[RequestsTableView alloc] init];
    _searchViewClient = [[SearchViewController alloc] init];
    _controllers = [NSMutableArray arrayWithArray:_sharedDelegate.navController.viewControllers];
}
-(void)setupProvider{
    
    
    //GotoRequests
    UIButton *requestButton = [_customGUI defaultMenuButton:[NSString stringWithFormat:@"Requests(%lu)", (unsigned long)_sharedDelegate.providerUser.requests.count]];
    requestButton.frame = CGRectMake(70, 200, (self.view.frame.size.width-140), 40);
    [requestButton addTarget:self action:@selector(gotoRequests:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestButton];
    
    UIButton *serviceButton = [_customGUI defaultMenuButton:@"Add Service"];
    serviceButton.frame = CGRectMake(70, 250, self.view.frame.size.width-140, 40);
    [serviceButton addTarget:self action:@selector(gotoServices:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:serviceButton];
    
    
    
    //Add target to Inbox
    [_inbox addTarget:self action:@selector(gotoInboxProvider:) forControlEvents:UIControlEventTouchUpInside];
    
    //Frame for Logout
    _logout.frame = CGRectMake(70, 300, (self.view.frame.size.width-140), 40);
    
    
}
-(void)setupClient{
    
    UIButton *SearchButton = [_customGUI defaultMenuButton:@"Search"];
    SearchButton.frame = CGRectMake(70, 200, self.view.frame.size.width-140, 40);
    [SearchButton addTarget:self action:@selector(gotoSearchViewClient:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:SearchButton];
    
    
    //Add target to Inbox
    [_inbox addTarget:self action:@selector(gotoInboxClient:) forControlEvents:UIControlEventTouchUpInside];
    //set frame of logout to be last in menu column.
    _logout.frame = CGRectMake(70, 250, (self.view.frame.size.width-140), 40);
}

@end
