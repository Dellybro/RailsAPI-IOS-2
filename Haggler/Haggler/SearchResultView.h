//
//  SearchResultView.h
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultView : UITableViewController

//For going to requestview
-(void)processDoubleTap:(UITapGestureRecognizer *)sender;
@property UITapGestureRecognizer* doubletap;

@end
