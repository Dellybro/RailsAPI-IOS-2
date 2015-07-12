//
//  SearchResultView.m
//  Haggler
//
//  Created by Travis Delly on 6/28/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "SearchResultView.h"
#import "AppDelegate.h"
#import "CustomGUI.h"
#import "CellForSearchResults.h"
#import "RequestProviderView.h"

@interface SearchResultView ()

@property AppDelegate *sharedDelegate;
@property CustomGUI *customGUI;

@end

@implementation SearchResultView

- (void)viewDidLoad {
    [super viewDidLoad];
    _sharedDelegate = [[UIApplication sharedApplication] delegate];
    
    
    [self setupHeader];
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
    return _sharedDelegate.listofProviders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellForSearchResults *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[CellForSearchResults alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    
    NSMutableDictionary *forCell = [_sharedDelegate.listofProviders objectAtIndex:indexPath.row];
    cell.user = forCell;
    cell.textLabel.text = [cell.user objectForKey:@"email"];
    cell.detailTextLabel.text = [cell.user objectForKey:@"name"];
    UIImage *theImage = [UIImage imageNamed:@"TableImage"];
    cell.imageView.image = theImage;
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)setupHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, self.view.frame.size.width, 30)];
    //labelView.backgroundColor = [UIColor whiteColor];
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.font = [UIFont fontWithName:@"Copperplate-Bold" size:28];
    labelView.textColor = [UIColor blackColor];
    labelView.text = @"Your search resulted in..";
    labelView.adjustsFontSizeToFitWidth = YES;
    
    UILabel *labelView2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, 30)];
    //labelView2.backgroundColor = [UIColor whiteColor];
    labelView2.textAlignment = NSTextAlignmentCenter;
    labelView2.font = [UIFont fontWithName:@"Copperplate-Bold" size:24];
    labelView2.textColor = [UIColor blackColor];
    labelView2.text = [NSString stringWithFormat:@"%lu!", (unsigned long)_sharedDelegate.listofProviders.count];
    labelView2.adjustsFontSizeToFitWidth = YES;
    
    UILabel *labelView3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 99, self.view.frame.size.width, 30)];
    //labelView3.backgroundColor = [UIColor whiteColor];
    labelView3.textAlignment = NSTextAlignmentCenter;
    labelView3.font = [UIFont fontWithName:@"Copperplate-Bold" size:20];
    labelView3.textColor = [UIColor blackColor];
    labelView3.text = @"Local Providers to help!";
    labelView3.adjustsFontSizeToFitWidth = YES;
    
    
    headerView.backgroundColor = [UIColor colorWithRed: 180.0/255.0 green: 238.0/255.0 blue:180.0/255.0 alpha: 1.0];
    [headerView addSubview:labelView];
    [headerView addSubview:labelView2];
    [headerView addSubview:labelView3];
    self.tableView.tableHeaderView = headerView;
    
    _doubletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processDoubleTap:)];
    [_doubletap setNumberOfTapsRequired:2];
    [_doubletap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:_doubletap];
    
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CellForSearchResults *cell = (CellForSearchResults*)[self.tableView cellForRowAtIndexPath:indexPath];
//}
-(void)processDoubleTap:(UITapGestureRecognizer *)sender{
    NSIndexPath* path = [self.tableView indexPathForSelectedRow];
    
    CellForSearchResults *cell = (CellForSearchResults*)[self.tableView cellForRowAtIndexPath:path];
    //get user from object dictionary at indexpath row
    
    RequestProviderView *show = [[RequestProviderView alloc] init];
    //revise
    Provider *forShow = [[Provider alloc] initWithJSON:cell.user];
    show.providerUser = forShow;
    [_sharedDelegate.navController pushViewController:show animated:YES];
    
}

@end
