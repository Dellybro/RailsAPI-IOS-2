//
//  ProviderHomeView.m
//  Haggler
//
//  Created by Travis Delly on 6/27/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "ProviderHomeView.h"
#import "AppDelegate.h"
#import "CustomGUI.h"
#import "MenuView.h"

@interface ProviderHomeView ()
@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;
@end

@implementation ProviderHomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    _customGUI = [[CustomGUI alloc] init];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"providerNavImage"] forBarMetrics:UIBarMetricsDefault];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    //Bar button items
    _menu = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(gotoMenu:)];
    self.navigationItem.rightBarButtonItem = _menu;
}
-(void)gotoMenu:(UIBarButtonItem*)sender{
    MenuView *MenuController = [[MenuView alloc] initWithType:[[Provider alloc] init]];
    MenuController.user = _sharedDelegate.providerUser.toDict;
    [_sharedDelegate.navController pushViewController:MenuController animated:YES];
}

@end
