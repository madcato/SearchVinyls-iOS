//
//  ViewController.h
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MostWantedTableViewController;

@interface ViewController : UIViewController <UITextFieldDelegate> {
@protected
    MostWantedTableViewController* _mostWantedController;
}

@end

