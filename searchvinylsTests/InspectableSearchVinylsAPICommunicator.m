//
//  InspectableSearchVinylsAPICommunicator.m
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "InspectableSearchVinylsAPICommunicator.h"

@interface SearchVinylsAPICommunicator ()

- (NSArray*)parseResponse:(NSData*)data onError:(ErrorBlock)errorBlock;

@end

@implementation InspectableSearchVinylsAPICommunicator

-(NSString*)fetchedURL {
    return [fetchedURL absoluteString];
}

-(void)doGetData:(NSURL*)url onSuccess:(CompletionBlock)completionBlock onError:(ErrorBlock)errorBlock {
    NSData* data = [self.expectedResponse dataUsingEncoding:NSUTF8StringEncoding];
    self.responseData = [self parseResponse:data onError:errorBlock];
}

-(NSString*)expectedResponse {
    if (_expectedResponse == nil) _expectedResponse = @"";
    return _expectedResponse;
    
}
@end
