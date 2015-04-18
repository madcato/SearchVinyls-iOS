//
//  InspectableSearchVinylsAPICommunicator.h
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "SearchVinylsAPICommunicator.h"

@interface InspectableSearchVinylsAPICommunicator : SearchVinylsAPICommunicator

-(NSString*)fetchedURL;

@property (nonatomic,strong) NSString* expectedResponse;

@end
