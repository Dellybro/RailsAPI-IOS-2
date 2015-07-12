//
//  HTTPHelper.m
//  Haggler
//
//  Created by Travis Delly on 6/25/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "HTTPHelper.h"
#import "AppDelegate.h"

@interface HTTPHelper()
@property AppDelegate *sharedDelegate;
@property NSString* baseURL;
@end


@implementation HTTPHelper

-(id)init{
    self = [super init];
    if (self){
        _sharedDelegate = [[UIApplication sharedApplication] delegate];
        _baseURL = @"http://localhost:3000/api";
        _returnedMessage = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(NSInteger)postMethod:(NSString*)typeOfUser action:(NSString*)action method:(NSString*)method post:(NSString*)post auth:(NSString*)auth_token{
    
    //setup url
    NSString* finalURL;
    if(method == nil){
        finalURL = [NSString stringWithFormat:@"%@/%@/%@", _baseURL, typeOfUser, action];
    } else {
        finalURL = [NSString stringWithFormat:@"%@/%@/%@%@", _baseURL, typeOfUser, action, method];
    }
    //setup request using mutableurlrequest
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:finalURL]];
    
    //setup postdata
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    //set request
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    if(!(auth_token == nil)){
        NSString *authValue = [NSString stringWithFormat:@"Token %@", auth_token];
        [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }
    
    //Make REQUEST
    NSHTTPURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:request
                                          returningResponse:&response
                                                      error:&error];
    //return status codes.
    if(error == nil){
        NSError *jsonError;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:&jsonError];
        NSLog(@"%@", json);
        _returnedMessage = json;
        return [response statusCode];
    } else {
        NSLog(@"%@", error);
        [_returnedMessage setObject:@"Error Occured" forKey:@"message"];
        return [response statusCode];
    }
}

-(id)MethodGet:(NSString*)typeOfUser action:(NSString*)action method:(NSString*)method{
    NSString *finalURL;
    if(method == nil){
        
        finalURL = [NSString stringWithFormat:@"%@/%@/%@", _baseURL, typeOfUser, action];
        
    } else {
        
        finalURL = [NSString stringWithFormat:@"%@/%@/%@%@", _baseURL, typeOfUser, action, method];
        
    }
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:finalURL]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    if(error == nil){
        NSError *jsonError;
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        NSLog(@"%@", json);
        return json;
    }
    
    return nil;
    
}


-(id)signin:(NSString *)username for:(NSString *)password fortype:(NSString*)typeOfUser{
    
    NSString *theURL = [NSString stringWithFormat:@"http://localhost:3000/api/%@/signin?email=%@&password=%@", typeOfUser, username, password];
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:theURL]];
    NSHTTPURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil){
        NSError *jsonError;
        id jsonArray = [NSJSONSerialization JSONObjectWithData:data
                                                       options:NSJSONReadingMutableContainers
                                                         error:&jsonError];
        NSMutableDictionary *jsonDictionary;
        
        //check if comes in as array or dictionary.
        jsonDictionary = ([jsonArray superclass] == [NSMutableDictionary class]) ? jsonArray : jsonArray[0];
        
        
        if([jsonDictionary objectForKey:@"message"]){
            _returnedMessage = (NSMutableDictionary*)jsonDictionary;
            return false;
        } else {
            return jsonDictionary;
        }
    } else {
        NSLog(@"error: %@", error);
    }
    return false;
}

-(void)alert:(NSString*)alertTitle with:(NSString*)alertMessage buttonAction:(UIAlertAction*)button{
    NSString *error = [[_sharedDelegate.HTTPRequest returnedMessage] objectForKey:alertTitle];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:alertMessage
                                                                   message:error
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:button];
    
    [_sharedDelegate.navController presentViewController:alert animated:YES completion:nil];
}

@end
