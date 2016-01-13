//
//  SearchViewController.m
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/11/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import "SearchViewController.h"
#import "ItunesService.h"

@interface SearchViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) ItunesService *service;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <ItunesResultItem> *searchResults;

@end

@implementation SearchViewController

#pragma mark UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.service = [[ItunesService alloc] init];
    self.searchResults = (NSArray <ItunesResultItem> *) @[];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *queryString = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    [self.service getItunesResultsWithQuery:queryString
                         andSuccessCallback:^(NSArray<ItunesResultItem> *response) {
                             
                             self.searchResults = response;
                             
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 [self.tableView reloadData];
                                 [self.view endEditing:YES];
                             });
    }
                                   andError:^(NSError *errorResponse) {
                                       NSLog(@"%@", errorResponse);
    }];
}

#pragma mark UITableView Delegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    ItunesResultItem *item = [self.searchResults objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.artistName;
    cell.detailTextLabel.text = item.trackName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
