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

@property (nonatomic, copy) void (^onSuccessCallback)(NSArray <ItunesResultItem>*);


@end

@implementation ItunesService

-(instancetype)init {
    self = [super init];
    
    self.baseUrlString = @"http://itunes.apple.com/search?term=";
    
    return self;
}

-(void)getItunesResultsWithQuery:(NSString *)query
              andSuccessCallback:(void(^)(NSArray <ItunesResultItem> *response))onSuccessCallback
                        andError:(void(^)(NSError *errorResponse))onErrorCallback {
    
    self.onSuccessCallback = onSuccessCallback;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.baseUrlString, query ];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    NSOperation *backgroundOperation = [[NSOperation alloc] init];
    backgroundOperation.queuePriority = NSOperationQueuePriorityLow;
    backgroundOperation.qualityOfService = NSOperationQualityOfServiceBackground;
    
    NSOperationQueue *operationQueue = [NSOperationQueue new];
    [operationQueue addOperation:backgroundOperation];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:operationQueue];
    
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
                                                    
                                                    [self performSelectorInBackground:@selector(parseItunesResultWithArrayOfDictionaries:) withObject:responseDictionary[@"results"]];
                                                    
                                                } else {
                                                    NSLog(@"An error occurred: %@", error.description);
                                                    
                                                    onErrorCallback (error);
                                                    
                                                }
                                            }];
    [task resume];
    
}

-(void)parseItunesResultWithArrayOfDictionaries:(NSArray*)dictionaryArray {
    
    NSMutableArray <ItunesResultItem> *result = (NSMutableArray <ItunesResultItem> *) @[].mutableCopy;
    
    [dictionaryArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ItunesResultItem *item = [[ItunesResultItem alloc] initWithDictionary:obj];
        [result addObject:item];
    }];
    
    self.onSuccessCallback(result);
    
}

-(void)loadAsyncImageDataWithURL:(NSURL *)imageURL
              andSuccessCallback:(void(^)(NSData *imageData))onSuccessCallback {
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError * _Nullable error) {
        if (data) {
            onSuccessCallback(data);
        }
    }];
    
    [task resume];
}

@end
