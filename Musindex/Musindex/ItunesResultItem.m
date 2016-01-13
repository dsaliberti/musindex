//
//  ItunesResultItem.m
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/12/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import "ItunesResultItem.h"
#import <UIKit/UIKit.h>

@implementation ItunesResultItem

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        self.wrapperType = dictionary[@"wrapperType"];
        self.artistName = dictionary[@"artistName"];
        self.trackName = dictionary[@"trackName"];
        self.artworkUrl60 = [NSURL URLWithString:dictionary[@"artworkUrl60"]];
        self.artworkUrl100 = [NSURL URLWithString:dictionary[@"artworkUrl100"]];
        self.collectionName = dictionary[@"collectionName"];
        
        self.currency = dictionary[@"currency"];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterCurrencyStyle;
        numberFormatter.currencyCode = self.currency;
        
        self.collectionPrice = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[dictionary[@"collectionPrice"] doubleValue]]];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        self.releaseDate = [dateFormatter dateFromString:dictionary[@"releaseDate"]];
    }
    return self;
}

@end
/*
 @property (nonatomic, strong) NSString *wrapperType;
 @property (nonatomic, strong) NSString *kind;
 @property (nonatomic, strong) NSNumber *artistId;
 @property (nonatomic, strong) NSNumber *collectionId;
 @property (nonatomic, strong) NSNumber *trackId;
 @property (nonatomic, strong) NSString *artistName;
 @property (nonatomic, strong) NSString *collectionName;
 @property (nonatomic, strong) NSString *trackName;
 @property (nonatomic, strong) NSString *collectionCensoredName;
 @property (nonatomic, strong) NSString *trackCensoredName;
 @property (nonatomic, strong) NSString *artistViewUrl;
 @property (nonatomic, strong) NSString *collectionViewUrl;
 @property (nonatomic, strong) NSString *trackViewUrl;
 @property (nonatomic, strong) NSString *previewUrl;
 @property (nonatomic, strong) NSString *artworkUrl30;
 @property (nonatomic, strong) NSString *artworkUrl60;
 @property (nonatomic, strong) NSString *artworkUrl100;
 @property (nonatomic, strong) NSString *collectionPrice;
 @property (nonatomic, strong) NSString *trackPrice;
 @property (nonatomic, strong) NSDate *releaseDate;
 @property (nonatomic, strong) NSString *collectionExplicitness;
 @property (nonatomic, strong) NSString *trackExplicitness;
 @property (nonatomic, strong) NSNumber *discCount;
 @property (nonatomic, strong) NSNumber *discNumber;
 @property (nonatomic, strong) NSNumber *trackCount;
 @property (nonatomic, strong) NSNumber *trackNumber;
 @property (nonatomic, strong) NSNumber *trackTimeMillis;
 @property (nonatomic, strong) NSString *country;
 @property (nonatomic, strong) NSString *currency;
 @property (nonatomic, strong) NSString *primaryGenreName;
 @property (nonatomic, strong) NSString *radioStationUrl;
 @property (nonatomic, assign) BOOL isStreamable;
 */