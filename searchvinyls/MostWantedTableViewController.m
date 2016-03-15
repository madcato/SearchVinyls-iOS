//
//  MostWantedTableViewController.m
//  searchvinyls
//
//  Created by Daniel Vela on 20/04/15.
//  Copyright (c) 2015 veladan. All rights reserved.
//

#import "MostWantedTableViewController.h"
#import "SearchVinylsAPICommunicator.h"
#import "ResultsTableViewController.h"

@interface MostWantedTableViewController () {
    NSArray* _mostWantedItems;
    SearchVinylsAPICommunicator* _communicator;
}

@end

@implementation MostWantedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if !(TARGET_OS_SIMULATOR)
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl beginRefreshing];
    [self.refreshControl addTarget:self action:@selector(launchSearch:) forControlEvents:UIControlEventValueChanged];
#endif

    [self launchSearch:self.refreshControl];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)launchSearch:(UIRefreshControl*)refreshControl
{
    _communicator = [SearchVinylsAPICommunicator instantiate];
    [_communicator getMostWanted:^(NSArray* array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger i = 0;
            NSMutableArray* rows = [NSMutableArray array];
            for (i = 0 ; i < [_mostWantedItems count] ; i++) {
                [rows addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
            _mostWantedItems = nil;
            [self.tableView deleteRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationAutomatic];
            _mostWantedItems = array;
            rows = [NSMutableArray array];
            for (i = 0 ; i < [array count] ; i++) {
                [rows addObject:[NSIndexPath indexPathForItem:i inSection:0]];
            }
            [self.tableView insertRowsAtIndexPaths:rows withRowAnimation:UITableViewRowAnimationBottom];
            if (self.refreshControl.refreshing) {
                [self.refreshControl endRefreshing];
            }
        });
    } onError:^(NSError *error) {
        if (self.refreshControl.refreshing) {
            [self.refreshControl endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_mostWantedItems count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Most Wanted";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MostWantedCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _mostWantedItems[indexPath.row][@"item"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultsTableViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ResultsTableViewController"];
    controller.textToSearch = _mostWantedItems[indexPath.row][@"item"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
