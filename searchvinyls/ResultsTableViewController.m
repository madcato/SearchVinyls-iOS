//
//  ResultsTableViewController.m
//  searchvinyls
//
//  Created by Daniel Vela on 20/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "SearchVinylsAPICommunicator.h"
#import "ResultsCell.h"
#import "UIImageView+Downloader.h"

@interface ResultsTableViewController () {
    NSArray* _results;
    SearchVinylsAPICommunicator* _communicator;
}

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Results";

#if !(TARGET_OS_SIMULATOR)
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(launchSearch:) forControlEvents:UIControlEventValueChanged];
    [self.refreshControl beginRefreshing];
#endif

    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height) animated:YES];

    [self launchSearch:self.refreshControl];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)launchSearch:(UIRefreshControl*)refreshControl
{
    _communicator = [SearchVinylsAPICommunicator instantiate];
    [_communicator searchFor:self.textToSearch onSuccess:^(NSArray* array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger i = 0;
            NSMutableArray* rows = [NSMutableArray array];
            for (i = 0 ; i < [_results count] ; i++) {
                [rows addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
            _results = nil;
            [self.tableView deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationBottom];
            _results = array;
            rows = [NSMutableArray array];
            for (i = 0 ; i < [array count] ; i++) {
                [rows addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
            [self.tableView insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationTop];
            if (self.refreshControl.refreshing) {
                [self.refreshControl endRefreshing];
            }
        });
    } onError:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultsCell *cell = (ResultsCell*)[tableView dequeueReusableCellWithIdentifier:@"ResultsCell" forIndexPath:indexPath];
    
    cell.label.text = _results[indexPath.row][@"title"];
    
    cell.image.tag = indexPath.row;
    NSString* urlString = _results[indexPath.row][@"image"];
    if (![urlString isEqual:[NSNull null]]) {
        [cell.image setImageFrom:urlString withTag:cell.image.tag];
    }

    return cell;
}

@end
