//
//  MainTableViewController.m
//  SearchBarExample
//
//  Created by fanghao on 2016/10/10.
//  Copyright © 2016年 fanghao. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()<UISearchControllerDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *searchResultArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation MainTableViewController

#pragma mark - getters and setters

- (UISearchController *)searchController
{
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
    }
    return _searchController;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameArray = @[@"fanghao",@"lanjuan",@"sjdf",@"weorwoer",@"xkvjjd",@"weroufc"];
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive) {
        return self.searchResultArray.count;
    }else{
        return self.nameArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellStyle" forIndexPath:indexPath];
    if (self.searchController.isActive) {
        cell.textLabel.text = self.searchResultArray[indexPath.row];
    }else{
        cell.textLabel.text = self.nameArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchResultsUpdating Delegate

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    
    self.searchResultArray = [self.nameArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
    NSLog(@"searching...");
}



@end
