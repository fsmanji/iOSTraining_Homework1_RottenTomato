//
//  FirstViewController.m
//  RotenTomatoClient
//
//  Created by Cristan Zhang on 9/15/15.
//  Copyright (c) 2015 FastTrack. All rights reserved.
//

#import "FirstViewController.h"
#import "MovieTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "RTMovie.h"
#import "MBProgressHUD.h"
#import "RTDetailViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property UIRefreshControl* refreshControl;

@property NSMutableArray* movieArray;
@end

@implementation FirstViewController

- (IBAction)onTapLeftImage:(UITapGestureRecognizer *)sender {
    //TODO: why there is an offset of 4 ????????
    int index = sender.view.tag - 4;
    RTMovie* movie = self.movieArray[index];
    
    NSLog(@"---- tapped on photo --- ");
    RTDetailViewController *detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"RTDetailViewController"];
    [detailController setMovie:movie];
    
    [self presentViewController:detailController animated:YES completion:nil];
}

- (IBAction)onTapRightImage:(UITapGestureRecognizer *)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //setup search bar
    self.searchBar.delegate = self;

    self.navigationItem.title = @"Top Movies";
    self.navigationItem.titleView.backgroundColor = [UIColor redColor];
    
    //setup table view
    [self.tableView setRowHeight:220];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //add a PTR control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onPullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    //self.tableView.estimatedRowHeight = 100;
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //load movie list
    [self sendRequest];
}

-(void)onPullToRefresh {
    [self.movieArray removeAllObjects];
    [self sendRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //self.searchSettings.searchString = searchBar.text;
    [searchBar resignFirstResponder];
    [self doSearch];
}

-(void)doSearch {
    
}

//Table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [self.movieArray count];
    return count / 2 + count % 2;
}

- (UITableViewCell* )tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"com.yahoo.moviecell" forIndexPath:indexPath];
    int index = indexPath.row *2;

    [cell initWithMovie:self.movieArray leftIndex:index rightIndex:index+1];
    /*UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    NSInteger row = indexPath.row;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",self.movieArray[row][@"title"],
                           self.movieArray[row][@"year"]];
    */
    return cell;
    
}


//delegates

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tapped row : %li", indexPath.row);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void) sendRequest{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [RTMovie fetchMovies:kCachedBoxOfficeUrl successCallback:^(NSArray *movies) {
        //save results
        if(!self.movieArray)
            self.movieArray = [[NSMutableArray alloc] init];
        
        [self.movieArray addObjectsFromArray:movies];
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.refreshControl endRefreshing];
    }];
  
}



@end
