//
//  SearchVinylsAPICommunicator.m
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "SearchVinylsAPICommunicator.h"

@implementation SearchVinylsAPICommunicator

-(NSString*)constructBasePath:(NSString*)method parameters:(NSDictionary*)parameters {

    NSString* paramsString = @"";
    for (id key in parameters) {
        if ([paramsString length] !=0 ){
            paramsString = [paramsString stringByAppendingString:@","];
        }
        NSString* name = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString* value = [parameters[key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        paramsString = [NSString stringWithFormat:@"%@%@=%@",paramsString, name, value];
    }
    NSString* baseUrl = [NSString stringWithFormat:@"%@/%@/%@?%@",SERVER_ADDRESS,API_PATH,method,paramsString];
    return baseUrl;
}

-(void)searchFor:(NSString*)query onSuccess:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    fetchedURL = [NSURL URLWithString:[self constructBasePath:SEARCH_METHOD parameters:@{@"c":query}]];
}

-(void)getMostWanted:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    fetchedURL = [NSURL URLWithString:[self constructBasePath:MOST_WANTED_METHOD parameters:nil]];
}

@end
