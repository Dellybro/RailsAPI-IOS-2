//
//  ConversationController.m
//  Haggler
//
//  Created by Travis Delly on 6/29/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "ConversationController.h"
#import "AppDelegate.h"
#import "MessageCells.h"
#import "CustomGUI.h"

@interface ConversationController ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;

@property float hspacing;
@property float vspacing;
@property NSMutableArray *constraintsForHeader;
@end

@implementation ConversationController

-(id)initWithType:(NSObject*)type{
    self = [super init];
    if(self){
        _type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messages.notes count];
}
static CGFloat padding = 25.0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[MessageCells alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    //Construct Cell
    cell.note = [_messages.notes objectAtIndex:((_messages.notes.count-indexPath.row)-1)];
    cell.senderAndTimeLabel.text = [cell.note objectForKey:@"created_at"];
    cell.messageContentView.text = [cell.note objectForKey:@"message"];
    
    long userNoteID = (long)[cell.note objectForKey:@"user_unique_id"];
    long userUnique = (long)[_user objectForKey:@"unique_id"];
    
    CGSize size = [cell.messageContentView.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height)*3);
    
    if (userNoteID == userUnique) { // sent messages
        
        [cell.messageContentView setFrame:CGRectMake(cell.frame.size.width/1.3, padding, ((cell.frame.size.width)-(cell.frame.size.width/1.3)),adjustedSize.height)];
        
    } else {
        
        [cell.messageContentView setFrame:CGRectMake(15, padding, adjustedSize.width/1.4, adjustedSize.height)];
        
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* note = [_messages.notes objectAtIndex:((_messages.notes.count-indexPath.row)-1)];
    CGSize size = [[note objectForKey:@"message"] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height)*3);
    return adjustedSize.height+(padding*2);
    
}

-(void)setup{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
    
    _header = [_customGUI defaultLabel:@"Send Message"];
    _header.frame = CGRectMake(0, 10, self.view.frame.size.width, 35);
    _header.adjustsFontSizeToFitWidth = YES;
    
    
    _messageView = [_customGUI defaultTextView];
    _messageView.text = @"insert message";
    _messageView.frame = CGRectMake(20, 55, self.view.frame.size.width-40, 60);
    
    _send = [_customGUI defaultButton:@"Send Message"];
    _send.frame = CGRectMake(100, 120, 175, 30);
    [_send addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    headerView.backgroundColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
    [headerView addSubview:_header];
    [headerView addSubview:_messageView];
    [headerView addSubview:_send];
    self.tableView.tableHeaderView = headerView;

//    [self landscapeCheck];
//    [self addConstraint];
    
}
//-(void)landscapeCheck{
//    if (UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
//        _vspacing = 15.0;
//        _hspacing = 30.0;
//    } else {
//        _vspacing = 10.0;
//        _hspacing = 20.0;
//    }
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    
//    [self landscapeCheck];
//    
//    if (_constraintsForHeader) {
//        [self.view removeConstraints:(NSArray *)_constraintsForHeader];
//    }
//    [self addConstraint];
//}
//
//-(void)addConstraint{
//    id topLayoutGuide = self.topLayoutGuide;
//    _constraintsForHeader = [[NSMutableArray alloc] init];
//    NSDictionary *variablesDictionary = NSDictionaryOfVariableBindings(_header, _messageView, _send, topLayoutGuide);
//    
//    [_constraintsForHeader addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_header]|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
//    [_constraintsForHeader addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_messageview]-(hspacing)-|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:_hspacing]} views:variablesDictionary]];
//    [_constraintsForHeader addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hspacing)-[_send]-(hspacing)|" options:0 metrics:@{@"hspacing" : [NSNumber numberWithFloat:(_hspacing*2)]} views:variablesDictionary]];
//    
//    [_constraintsForHeader addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-(vspacing)-[_header]-(vspacing)-[_messageView]-(vspacing)-[_send]" options:0 metrics:@{@"vspacing" : [NSNumber numberWithFloat:_vspacing]} views:variablesDictionary]];
//    
//    
//    [self.view addConstraints:_constraintsForHeader];
//    
//}
-(void)sendMessage:(UIButton*)sender{
    //NSString *method = [NSString stringWithFormat:@""];
    //MessageCells cell =
    
    NSString *post = [NSString stringWithFormat:@"note[message]=%@&note[user_unique_id]=%@&message[message_id]=%@&message[provider_unique]=%@&message[client_unique]=%@", _messageView.text, [_user objectForKey:@"unique_id"], _messages.message_id, _messages.provider_id, _messages.client_id];
    [_sharedDelegate.HTTPRequest postMethod:@"inbox" action:@"create" method:nil post:post auth:nil];
    
    NSString* method;
    
    ([_type class] == [Provider class]) ? (method = [NSString stringWithFormat:@"?provider[id]=%@", _messages.provider_id]) : (method = [NSString stringWithFormat:@"?client[id]=%@", _messages.client_id]);
    
    _messages = [[Message alloc] initWithJson:[[_sharedDelegate.HTTPRequest MethodGet:@"inbox" action:@"get_messages" method:method] objectAtIndex:_messageNumber]];
    
    [self.tableView reloadData];
    
}

@end
