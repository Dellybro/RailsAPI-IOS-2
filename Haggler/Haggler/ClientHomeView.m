//
//  ClientHomeView.m
//  Haggler
//
//  Created by Travis Delly on 6/27/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "ClientHomeView.h"
#import "CustomGUI.h"
#import "AppDelegate.h"
#import "MenuView.h"
#import "SearchResultView.h"

@interface ClientHomeView ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;

@end

@implementation ClientHomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    _customGUI = [[CustomGUI alloc] init];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"UserNav"] forBarMetrics:UIBarMetricsDefault];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mymethods
-(void)quickSearch:(UIButton*)sender{
    _sharedDelegate.listofProviders = [_sharedDelegate.HTTPRequest MethodGet:@"providers" action:@"index" method:nil];
    
    SearchResultView *resultController = [[SearchResultView alloc] init];
    [_sharedDelegate.navController pushViewController:resultController animated:YES];
    
    
}

-(void)gotoMenu:(UIBarButtonItem*)sender{
    MenuView *MenuController = [[MenuView alloc] initWithType:[[Client alloc] init]];
    MenuController.user = _sharedDelegate.clientUser.toDict;
    [_sharedDelegate.navController pushViewController:MenuController animated:YES];
}

//Setups

-(void)setup{
    _BottomBarQuickSearch = [_customGUI defaultView];
    _BottomBarQuickSearch.frame = CGRectMake(0, 450, self.view.frame.size.width, (self.view.frame.size.height-450));
    
    _quickSearchField = [_customGUI defaultTextField:@"quick search"];
    _quickSearchField.frame = CGRectMake(70, 55, self.view.frame.size.width-140, 30);
    
    _quickSearchButton = [_customGUI defaultButton:@"Search"];
    _quickSearchButton.frame = CGRectMake(120, 95, self.view.frame.size.width-240, 30);
    [_quickSearchButton addTarget:self action:@selector(quickSearch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Setup Barbutton items.
    _menu = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(gotoMenu:)];
    
    [_BottomBarQuickSearch.viewForBaselineLayout addSubview:_quickSearchButton];
    [_BottomBarQuickSearch.viewForBaselineLayout addSubview:_quickSearchField];
    [self.view addSubview:_BottomBarQuickSearch];
    self.navigationItem.rightBarButtonItem = _menu;
    
    
    
    //Keyboard stuff
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    
    
    [self.view addGestureRecognizer:tap];
    [self addConstraints];
    [self setupKeyboardActivity];
    
    
}
-(void)setupKeyboardActivity{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:@"UIKeyboardDidHideNotification" object:nil];
    
}
-(void)keyboardWillShow:(NSNotification *)note{
    NSLog(@"keyboard unhidden");
    NSDictionary *userInfo = [note userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.origin.y = frame.origin.y-kbSize.height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.frame = frame;
    }];
    
}
- (void) keyboardDidHide:(NSNotification *)note {
    NSLog(@"keyboard hidden");
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.view.frame = frame;
    }];
}
-(void)dismissKeyboard:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}
-(void)addConstraints{
    
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeRight;
}

-(BOOL)shouldAutorotate {
    return NO;
}

@end
