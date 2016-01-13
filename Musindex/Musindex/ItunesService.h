//
//  ItunesService.h
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/11/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItunesResultItem.h"

@interface ItunesService : NSObject

-(void)getItunesResultsWithQuery:(NSString *)query
              andSuccessCallback:(void(^)(NSArray <ItunesResultItem> *response))onSuccessCallback
                        andError:(void(^)(NSError *errorResponse))onErrorCallback;

-(void)loadAsyncImageDataWithURL:(NSURL *)imageURL
              andSuccessCallback:(void(^)(NSData *imageData))onSuccessCallback;

@end
