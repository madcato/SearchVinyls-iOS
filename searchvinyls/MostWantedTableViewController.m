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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl beginRefreshing];
    [self.refreshControl addTarget:self action:@selector(launchSearch:) forControlEvents:UIControlEventValueChanged];
    
    [self launchSearch:self.refreshControl];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)launchSearch:(UIRefreshControl*)refreshControl
{
    _communicator = [[SearchVinylsAPICommunicator alloc] init];
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
            [self.refreshControl endRefreshing];
        });
    } onError:^(NSError *error) {
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
