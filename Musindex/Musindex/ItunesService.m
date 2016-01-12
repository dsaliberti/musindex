//
//  ItunesService.m
//  Musindex
//
//  Created by Danilo Soares Aliberti on 1/11/16.
//  Copyright © 2016 dsaliberti. All rights reserved.
//

#import "ItunesService.h"

@interface ItunesService ()

@property (nonatomic, strong) NSString *baseUrlString;

@end

@implementation ItunesService

-(instancetype)init {
    self = [super init];
    
    self.baseUrlString = @"http://itunes.apple.com/search?term=";
    
    return self;
}

-(void)getItunesResultsWithQuery:(NSString *)query
              andSuccessCallback:(void(^)(NSDictionary *response))onSuccessCallback
                        andError:(void(^)(NSError *errorResponse))onErrorCallback {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.baseUrlString, query ];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    NSDictionary *responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    NSLog(@"Response: %@", responseDictionary);
                                                    
                                                    onSuccessCallback( responseDictionary );
                                                    
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                    
                                                    onErrorCallback (error);
                                                    
                                                }
                                            }];
    [task resume];
    
}

@end
