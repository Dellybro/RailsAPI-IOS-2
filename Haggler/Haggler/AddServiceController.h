//
//  AddServiceController.h
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddServiceController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property UILabel *header;

@property UITextField *serviceToAdd;

@property UIButton *addService;

@property NSMutableArray *providerServiceList;

@property UIPickerView *currentServices;

@end
