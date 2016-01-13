//
//  DetailViewController.h
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/13/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItunesResultItem.h"

@interface DetailViewController : UIViewController
@property(nonatomic, strong) ItunesResultItem *item;
@end
