//
//  SearchViewController.m
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "SearchViewController.h"
#import "AppDelegate.h"
#import "CustomGUI.h"
#import "SearchResultView.h"

@interface SearchViewController ()

@property CustomGUI *customGUI;
@property AppDelegate *sharedDelegate;
@property (nonatomic) float vspacing;
@property (nonatomic) float hspacing;
@property (strong, nonatomic) NSMutableArray *constraints;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(100, 350)];
    [path addLineToPoint:CGPointMake(275.0, 350)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    
    [self setupGestures];
    [self setup];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:shapeLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}
-(void)selectState:(UIButton*)sender{
    NSLog(@"%@", _customGUI.stateString);
    _stateSelectionField.text = _customGUI.stateString;
    [_stateSelectionField reloadInputViews];
    [_stateSelectionField resignFirstResponder];
}
-(void)setupGestures{
    UITapGestureRecognizer *closeText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:closeText];
}
-(void)dismissKeyboard:(UIGestureRecognizer*)sender{
    [self.view endEditing:YES];
}

-(void)searchResult:(UIButton *)sender{
    
    NSMutableString *method = [[NSMutableString alloc] initWithString:@"?"];
    
    if (![_city.text isEqual:@""]){
        [method appendString:[NSString stringWithFormat:@"search[city]=%@&", _city.text]];
    }
    if (![_stateSelectionField.text isEqual:@""]){
        [method appendString:[NSString stringWithFormat:@"search[state]=%@&", _stateSelectionField.text]];
    }
    if (![_serviceField.text isEqual:@""]){
        [method appendString:[NSString stringWithFormat:@"search[service]=%@&", _serviceField.text]];
    }
    if (![_emailSearch.text isEqual:@""]){
        [method appendString:[NSString stringWithFormat:@"search[email]=%@&", _emailSearch.text]];
    }
    if (![_nameSearch.text isEqual:@""]){
        [method appendString:[NSString stringWithFormat:@"search[first_name]=%@&", _nameSearch.text]];
    }
    
    _sharedDelegate.listofProviders = [_sharedDelegate.HTTPRequest MethodGet:@"clients" action:@"searchViewResult" method:method];
    
    NSLog(@"method: %@", method);
    
    SearchResultView *results = [[SearchResultView alloc] init];
    
    [_sharedDelegate.navController pushViewController:results animated:YES];
    
}

-(void)setup{
    
    //Setup self.view
    _controllerTitle = [_customGUI defaultLabel:@"Search for a Provider!"];
    _controllerTitle.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Triple 3
    _nameSearch = [_customGUI defaultTextField:@"name"];
    _nameSearch.translatesAutoresizingMaskIntoConstraints = NO;
    
    _emailSearch = [_customGUI defaultTextField:@"email"];
    _emailSearch.translatesAutoresizingMaskIntoConstraints = NO;
    
    _picker = _customGUI.statePickerKeyboard;
    [_customGUI.doubletap addTarget:self action:@selector(selectState:)];
    _stateSelectionField = [_customGUI defaultTextFieldWithText:[NSString stringWithFormat:@"%@", _sharedDelegate.clientUser.state]];
    [_stateSelectionField setInputView:_picker];
    _stateSelectionField.translatesAutoresizingMaskIntoConstraints = NO;
    _stateSelectionField.delegate = self;
    _stateSelectionField.tintColor = [UIColor whiteColor];
    
    _city = [_customGUI defaultTextFieldWithText:[NSString stringWithFormat:@"%@", _sharedDelegate.clientUser.city]];
    _city.translatesAutoresizingMaskIntoConstraints = NO;
    
    _serviceField = [_customGUI defaultTextField:@"service"];
    _serviceField.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _search = [_customGUI defaultButton:@"Search!"];
    _search.translatesAutoresizingMaskIntoConstraints = NO;
    [_search addTarget:self action:@selector(searchResult:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_city];
    [self.view addSubview:_emailSearch];
    [self.view addSubview:_nameSearch];
    [self.view addSubview:_stateSelectionField];
    [self.view addSubview:_search];
    [self.view addSubview:_controllerTitle];
    [self.view addSubview:_serviceField];
    self.view.layer.borderWidth = 10;
    
    
    [self landscapeCheck];
    [self setupConstraints];
    
}

-(void)setupConstraints{
    id topLayoutGuide = self.topLayoutGuide;
    
    _constraints = [[NSMutableArray alloc] init];
    
    NSDictionary *variablesDictionary = NSDictionaryOfVariableBindings(_controllerTitle, _nameSearch, _emailSearch, _stateSelectionField, _city, _serviceField, _search, topLayoutGuide);
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_controllerTitle]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nameSearch][_emailSearch(==_nameSearch)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_stateSelectionField][_city(==_stateSelectionField)]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_serviceField]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_search]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:(_hspacing*2)]} views:variablesDictionary]];
    
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_controllerTitle]-(vspacing)-[_nameSearch(30.0)]-(vspacing)-[_stateSelectionField(30.0)]-(vspacing)-[_serviceField(30.0)]-(vspacing)-[_search]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    [_constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_controllerTitle]-(vspacing)-[_emailSearch(30.0)]-(vspacing)-[_city(30.0)]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
    
    [self.view addConstraints:(NSArray *)_constraints];
    
}
-(void)landscapeCheck{
    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        _vspacing = 20.0;
        _hspacing = 20.0;
    } else {
        _vspacing = 50.0;
        _hspacing = 50.0;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [self landscapeCheck];
    
    if (_constraints) {
        [self.view removeConstraints:(NSArray *)_constraints];
    }
    [self setupConstraints];
}



@end
