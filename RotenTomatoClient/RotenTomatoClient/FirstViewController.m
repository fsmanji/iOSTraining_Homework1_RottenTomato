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

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property UIRefreshControl* refreshControl;

@property NSMutableArray* movieArray;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //setup search bar
    self.searchBar.delegate = self;

    self.navigationItem.title = @"Top Movies";
    self.navigationItem.titleView.backgroundColor = [UIColor redColor];
    
    //setup table view
    [self.tableView setRowHeight:320];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //add a PTR control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onPullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    //load movie list
    [self sendRequest];
}

-(void)onPullToRefresh {
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
    return count;
}

- (UITableViewCell* )tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"com.yahoo.moviecell" forIndexPath:indexPath];
    int index = indexPath.row *2;
    RTMovie* movie1 = self.movieArray[index];
    RTMovie* movie2;
    if(index + 1 < [self.movieArray count]) {
        movie2 = self.movieArray[index + 1];
    }
    [cell initWithMovieLeft:movie1 andMovieRight:movie2];
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
    }];
  
}



@end
