//
//  MenuView.h
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuView : UIViewController

-(id)initWithType:(NSObject*)type;

@property NSObject* type;
@property NSMutableArray *controllers;
@property UIButton *logout;
@property UIButton *inbox;
@property NSMutableDictionary* user;

@end
