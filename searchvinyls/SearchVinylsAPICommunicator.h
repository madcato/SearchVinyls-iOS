//
//  SearchVinylsAPICommunicator.h
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_ADDRESS @"http://searchvinyls.appspot.com"

#define API_PATH @"api"

#define SEARCH_METHOD @"search"
#define MOST_WANTED_METHOD @"mostwanted"

typedef void(^CompletionBlock)(NSArray* response);
typedef void(^ErrorBlock)(NSError* error);

@interface SearchVinylsAPICommunicator : NSObject {
@protected
    NSURL* fetchedURL;
}

-(void)searchFor:(NSString*)query onSuccess:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock;
-(void)getMostWanted:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock;

@end
