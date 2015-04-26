//
//  UIView+Downloader.h
//  netapp
//
//  Created by Daniel Vela on 13/07/12.
//  Copyright (c) 2012 Inycom. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OSWebRequest;

@interface UIImageView (Downloader)

@property (readwrite, nonatomic, retain, setter = af_setImageRequestOperation:)
        OSWebRequest *osWebRequestObject;

-(void)setImageFrom:(NSString*)url withTag:(NSInteger)tag;

@end
