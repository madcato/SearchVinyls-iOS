//
//  UIView+Downloader.m
//  netapp
//
//  Created by Daniel Vela on 13/07/12.
//  Copyright (c) 2012 Inycom. All rights reserved.
//

#import "UIImageView+Downloader.h"
#import <objc/runtime.h>


static NSMutableDictionary* imageCache = nil;

static char kOSWebRequestObjectKey = 's';

@implementation UIImageView (Downloader)
@dynamic osWebRequestObject;

- (OSWebRequest *)osWebRequestObject {
  return (OSWebRequest *)objc_getAssociatedObject(self,
                          &kOSWebRequestObjectKey);
}

- (void)setOsWebRequestObject:(OSWebRequest *)imageRequestOperation {
  objc_setAssociatedObject(self,
               &kOSWebRequestObjectKey,
               imageRequestOperation,
               OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setImageFrom:(NSString*)url withTag:(NSInteger)tag {
  UIImage* cachedImage = [self getCachedImage:url];
  if(cachedImage != nil) {
    [self setImage:cachedImage];
  } else {
    
      NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
      NSURLSession *manager = [NSURLSession sessionWithConfiguration:configuration];
      
      NSURL *URL = [NSURL URLWithString:url];
      NSURLRequest *request = [NSURLRequest requestWithURL:URL];
      
      NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request completionHandler:^(NSURL* location, NSURLResponse* response, NSError* error){
          NSHTTPURLResponse* urlResponse = (NSHTTPURLResponse*)response;
          if(error == nil) {
              UIImage* image;
              if([urlResponse statusCode] == 200) {
                  image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                  if(image != nil) {
                      [self setCachedImage:image forKey:url];
                      if((self.tag == tag) || (tag == -1)) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self setImage:image];
                          });
                      }
                  }
                  else {
                      NSLog(@"BAD IMAGE: %@",url);
                  }
              }
          } else {
              NSLog(@"ERROR %@", [error description]);
          }
          [self setOsWebRequestObject:nil];
          
      }];
      [downloadTask resume];
  }
}

-(void)setCachedImage:(UIImage*)image forKey:(NSString*)key {
  if(imageCache == nil) {
    imageCache = [NSMutableDictionary dictionary];
  }
  imageCache[key] = image;
}

-(UIImage*)getCachedImage:(NSString*)key {
  if(imageCache == nil) {
    imageCache = [NSMutableDictionary dictionary];
  }
  return imageCache[key];
}

@end
