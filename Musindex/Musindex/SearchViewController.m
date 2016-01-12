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
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.service = [[ItunesService alloc] init];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSString *queryString = [searchBar.text stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    [self.service getItunesResultsWithQuery:queryString
                         andSuccessCallback:^(NSDictionary *response) {
                             NSLog(@":) ");
                         }
                                   andError:^(NSError *errorResponse) {
                                       NSLog(@"error %@", errorResponse);
                                   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
