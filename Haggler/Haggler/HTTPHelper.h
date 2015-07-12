//
//  HTTPHelper.h
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HTTPHelper : NSObject <UIAlertViewDelegate>


//final methods
-(id)signin:(NSString *)username for:(NSString *)password fortype:(NSString*)typeOfUser;
@property NSMutableDictionary* returnedMessage;
-(NSInteger)postMethod:(NSString*)typeOfUser action:(NSString*)action method:(NSString*)method post:(NSString*)post auth:(NSString*)auth_token;
-(id)MethodGet:(NSString*)typeOfUser action:(NSString*)action method:(NSString*)method;
-(void)alert:(NSString*)alertTitle with:(NSString*)alertMessage buttonAction:(UIAlertAction*)button;


@end
