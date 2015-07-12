//
//  InboxController.m
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "InboxController.h"
#import "AppDelegate.h"
#import "InboxCells.h"
#import "ConversationController.h"
#import "CustomGUI.h"

@interface InboxController ()

@property CustomGUI *customGUI;
@property AppDelegate *sharedDelgate;

@end

@implementation InboxController


-(id)initWithType:(NSObject*)type{
    self = [super init];
    if (self){
        _type = type;
        _sharedDelgate = [[UIApplication sharedApplication] delegate];
        _customGUI = [[CustomGUI alloc] init];
        [self setup];
        if([type class] == [Provider class]){
            _user = _sharedDelgate.providerUser.toDict;
        }else if ([type class] == [Client class]){
            _user = _sharedDelgate.clientUser.toDict;
        }
        
        NSString* method = [NSString stringWithFormat:@"?provider[id]=%@", [_user objectForKey:@"id"]];
        
        _messages = [_sharedDelgate.HTTPRequest MethodGet:@"inbox" action:@"get_messages" method:method];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InboxCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[InboxCells alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    
    
    Message *forCell = [[Message alloc] initWithJson:[_messages objectAtIndex:indexPath.row]];
    NSMutableDictionary *userForCell;
    if([_type class] == [Provider class]){
        userForCell = [_sharedDelgate.HTTPRequest MethodGet:@"users" action:@"show" method:[NSString stringWithFormat:@"?client[id]=%@", forCell.client_id]];
        
    } else if ([_type class] == [Client class]){
        userForCell = [_sharedDelgate.HTTPRequest MethodGet:@"users" action:@"show" method:[NSString stringWithFormat:@"?provider[id]=%@", forCell.provider_id]];
        
    }
    cell.FromUser = userForCell;
    cell.messageForUser = forCell;
    
    NSString* textLabel = [NSString stringWithFormat:@"Message With: %@", [cell.FromUser objectForKey:@"first_name"]];
    cell.detailTextLabel.text = textLabel;
    cell.textLabel.text = cell.messageForUser.messageTitle;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InboxCells *cell = (InboxCells*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    ConversationController *conversationController = [[ConversationController alloc] initWithType:_type];
    conversationController.user = _user;
    conversationController.messages = cell.messageForUser;
    conversationController.messageNumber = indexPath.row;
    
    [_sharedDelgate.navController pushViewController:conversationController animated:YES];
    
}
-(void)setup{
    //Header and stuff
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    UILabel *header = [_customGUI defaultLabel:@"Inbox"];
    header.textColor = [UIColor whiteColor];
    header.frame = CGRectMake(0, 10, self.view.frame.size.width, 35);
    header.adjustsFontSizeToFitWidth = YES;
    
    headerView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:header];
    self.tableView.tableHeaderView = headerView;
    
}

@end
