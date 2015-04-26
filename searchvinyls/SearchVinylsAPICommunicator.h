//
//  SearchVinylsAPICommunicator.h
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <Foundation/Foundation.h>


// Production
#define SERVER_ADDRESS @"http://searchvinyls.appspot.com"

// Development
// #define SERVER_ADDRESS @"http://localhost:3000"

#define API_PATH @"api"

#define SEARCH_METHOD @"search"
#define MOST_WANTED_METHOD @"mostwanted"

typedef void(^CompletionBlock)(NSArray* response);
typedef void(^ErrorBlock)(NSError* error);

@interface SearchVinylsAPICommunicator : NSObject {
    NSURL* fetchedURL;
}

@property (nonatomic, strong) NSArray* responseData;

-(void)searchFor:(NSString*)query onSuccess:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock;
-(void)getMostWanted:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock;

@end
