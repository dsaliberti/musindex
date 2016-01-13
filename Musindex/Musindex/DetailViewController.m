//
//  DetailViewController.m
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/13/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import "DetailViewController.h"
#import "ItunesService.h"
@interface DetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *albumNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *releaseDateLabel;


@end

#pragma mark UIViewController Lifecycle

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.item) {
        return;
    }
    //TODO: setup a viewModel object here to remove the model to be formatted directly in the viewController;
    //TODO2: hide not used labels to fit better the screen;
    
    self.trackNameLabel.text = self.item.trackName;
    self.albumNameLabel.text = self.item.collectionName;
    self.artistNameLabel.text = self.item.artistName;
    self.priceLabel.text = self.item.collectionPrice;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.releaseDateLabel.text = [dateFormatter stringFromDate:self.item.releaseDate];
    
    self.imageView.image = [UIImage imageNamed:@"placeholder60"];
    ItunesService *service = [[ItunesService alloc] init];
    [service loadAsyncImageDataWithURL:self.item.artworkUrl100
                    andSuccessCallback:^(NSData *imageData) {
                            //TODO: save image data to cache too
                            dispatch_async(dispatch_get_main_queue(), ^{
                                 self.imageView.image = [UIImage imageWithData:imageData];
                            });
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
