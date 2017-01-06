//
//  MainTableViewController.m
//  SearchBarExample
//
//  Created by fanghao on 2016/10/10.
//  Copyright © 2016年 fanghao. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()<UISearchControllerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *searchResultArray;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;

@end

@implementation MainTableViewController

#pragma mark - getters and setters

- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameArray = @[@"fanghao",@"lanjuan",@"sjdf",@"weorwoer",@"xkvjjd",@"weroufc"];
    
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsDelegate = self;
    
    self.definesPresentationContext = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.nameArray.count;
    }else{
        return self.searchResultArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellStyle"];
    
    if (tableView == self.tableView) {
        cell.textLabel.text = self.nameArray[indexPath.row];
    }else{
        cell.textLabel.text = self.searchResultArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"push" sender:self];
}


#pragma mark - UISearchDisplayController Delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(nullable NSString *)searchString
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@",searchString];
    
    self.searchResultArray = [self.nameArray filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
    return YES;
}



@end
