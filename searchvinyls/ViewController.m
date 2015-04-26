//
//  ViewController.m
//  searchvinyls
//
//  Created by Daniel Vela on 16/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "ViewController.h"
#import "MostWantedTableViewController.h"
#import "ResultsTableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet UIView *positionForTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inputField.alpha = 0.0;
    
    self.title = @"Search";
    [self.navigationController setNavigationBarHidden:YES];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration:0.8 animations:^{
        self.inputField.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.inputField.alpha = 1.0;
    }];
    
    if (_mostWantedController == nil) {
        _mostWantedController = [self.storyboard instantiateViewControllerWithIdentifier:@"MostWantedTableViewController"];
        [self addChildViewController:_mostWantedController];
        _mostWantedController.view.frame = self.positionForTV.frame;
        [self.view addSubview:_mostWantedController.view];
        [_mostWantedController didMoveToParentViewController:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    // Launch search and result controller
    ResultsTableViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsTableViewController"];
    controller.textToSearch = self.inputField.text;
    [self.navigationController pushViewController:controller animated:YES];
    
    return YES;
}

@end
