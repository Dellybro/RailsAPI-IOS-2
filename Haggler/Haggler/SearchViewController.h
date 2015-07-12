//
//  SearchViewController.h
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITextFieldDelegate>

@property UILabel *controllerTitle;
@property UIButton *search;
@property UITextField *serviceField;
@property UITextField *nameSearch;
@property UITextField *emailSearch;
@property UITextField *stateSelectionField;
@property UITextField *ratingLevel;
@property UIView *picker;
@property UITextField *city;


-(void)searchResult:(UIButton*)sender;

@end
