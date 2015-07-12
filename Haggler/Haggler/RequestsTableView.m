//
//  RequestsTableView.m
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "RequestsTableView.h"
#import "AppDelegate.h"
#import "RequestCells.h"
#import "CustomGUI.h"
#import "RequestViewController.h"

@interface RequestsTableView ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;

@end

@implementation RequestsTableView

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    _customGUI = [[CustomGUI alloc] init];
    
    [self setup];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return _sharedDelegate.providerUser.requests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RequestCells *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[RequestCells alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    NSNumber* forCell = [[_sharedDelegate.providerUser.requests objectAtIndex:indexPath.row] objectForKey:@"client_id"];
    NSMutableDictionary *userForCell = [_sharedDelegate.HTTPRequest MethodGet:@"users" action:@"show_with_unique" method:[NSString stringWithFormat:@"?client[unique_id]=%@", forCell]];
    NSLog(@"%@",userForCell);
    cell.user = userForCell;
    cell.textLabel.text = [cell.user objectForKey:@"email"];
    cell.detailTextLabel.text = [cell.user objectForKey:@"first_name"];
    UIImage *theImage = [UIImage imageNamed:@"TableImage"];
    cell.imageView.image = theImage;
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RequestViewController *requestControl = [[RequestViewController alloc] init];
    
    RequestCells *cellForRow = (RequestCells*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    requestControl.showedClient = [[Client alloc] initWithJSON:cellForRow.user];
    requestControl.request = [_sharedDelegate.providerUser.requests objectAtIndex:indexPath.row];
    [_sharedDelegate.navController pushViewController:requestControl animated:YES];
}

-(void)setup{
    //Header and stuff
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
    UILabel *header = [_customGUI defaultLabel:@"Requests"];
    header.textColor = [UIColor whiteColor];
    header.frame = CGRectMake(0, 10, self.view.frame.size.width, 35);
    header.adjustsFontSizeToFitWidth = YES;
    
    headerView.backgroundColor = [UIColor blackColor];
    [headerView addSubview:header];
    self.tableView.tableHeaderView = headerView;
    
}

@end
