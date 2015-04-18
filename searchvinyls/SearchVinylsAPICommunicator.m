//
//  SearchVinylsAPICommunicator.m
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "SearchVinylsAPICommunicator.h"

@implementation SearchVinylsAPICommunicator

-(void)searchFor:(NSString*)query onSuccess:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    fetchedURL = [NSURL URLWithString:[self constructBasePath:SEARCH_METHOD parameters:@{@"c":query}]];
    [self doGetData:fetchedURL onSuccess:compBlock onError:errorBlock];
}

-(void)getMostWanted:(CompletionBlock)compBlock onError:(ErrorBlock)errorBlock {
    fetchedURL = [NSURL URLWithString:[self constructBasePath:MOST_WANTED_METHOD parameters:nil]];
    [self doGetData:fetchedURL onSuccess:compBlock onError:errorBlock];
}

-(void)doGetData:(NSURL*)url onSuccess:(CompletionBlock)completionBlock onError:(ErrorBlock)errorBlock {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *manager = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            if (errorBlock) errorBlock(error);
        } else {
            self.responseData = [self parseResponse:data onError:errorBlock];
            if (completionBlock) completionBlock(self.responseData);
        }
    }];
    [dataTask resume];
}

- (NSArray*)parseResponse:(NSData*)data onError:(ErrorBlock)errorBlock {
    NSError* error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        if (errorBlock) errorBlock(error);
        return nil;
    }
    assert([jsonObject isKindOfClass:[NSDictionary class]]);
    NSArray* responseData = jsonObject[@"items"];
    assert([responseData isKindOfClass:[NSArray class]]);
    return responseData;
}

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

@end
