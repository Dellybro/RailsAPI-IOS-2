//
//  AppDelegate.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Setup helpers
    //Set users initally nil
    _clientUser = nil;
    _providerUser = nil;
    //Create fake user for lists
    NSDictionary *nilUser = [[NSDictionary alloc] initWithObjectsAndKeys:@"value", @"name", nil];
    _listofClients = [[NSMutableArray alloc] initWithObjects:nilUser, nil];
    _listofProviders = [[NSMutableArray alloc] initWithObjects:nilUser, nil];
    _listOfStates = [[NSMutableArray alloc] initWithObjects:@"AL", @"AR", @"AS", @"AZ", @"CA", @"CO", @"CT", @"DC", @"DE", @"FL", @"FM", @"GA", @"GU", @"HI", @"IA", @"ID", @"IL", @"IN", @"KS", @"KY", @"LA", @"MA", @"MD", @"ME", @"MH", @"MI", @"MN", @"MO", @"MP", @"MS", @"MT", @"NC", @"ND", @"NE", @"NH", @"NJ", @"NM", @"NV", @"NY", @"OH", @"OK", @"OR", @"PA", @"RI", @"SC", @"SD", @"TN", @"TX", @"UT", @"VA", @"VI", @"VT", @"WA", @"WI", @"WV", @"WY", nil];
    _HTTPRequest = [[HTTPHelper alloc] init];
    
    //Setup window
    _rootView = [[HomePage alloc] init];
    _resetStack = [[NSMutableArray alloc] initWithObjects:_rootView, nil];
    _navController = [[UINavigationController alloc] initWithRootViewController:_rootView];
    
    [self loggedIn];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:_navController];
    [_navController popToRootViewControllerAnimated:NO];
    
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}
-(void)loggedIn{
    if(_clientUser == nil && _providerUser == nil){
        [_navController setViewControllers:_resetStack animated:YES];
    } else {
        //do nothing
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
