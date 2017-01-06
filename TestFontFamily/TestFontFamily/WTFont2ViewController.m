//
//  WTFont2ViewController.m
//  TestFontFamily
//
//  Created by fanghao on 2017/1/6.
//  Copyright © 2017年 fanghao. All rights reserved.
//

#import "WTFont2ViewController.h"

@interface WTFont2ViewController ()

@property (nonatomic, strong) NSArray *fontFamilyArray;

@end

@implementation WTFont2ViewController

#pragma mark - getters

- (NSArray *)fontFamilyArray
{
    if (!_fontFamilyArray) {
        _fontFamilyArray = [[NSArray alloc] init];
    }
    return _fontFamilyArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 60.0f;
    
    self.fontFamilyArray = [[UIFont familyNames] sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.fontFamilyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *fontFamily = self.fontFamilyArray[section];
    NSArray *fontNameArray = [UIFont fontNamesForFamilyName:fontFamily];
    return fontNameArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *fontFamily = self.fontFamilyArray[section];
    return fontFamily;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fontCell" forIndexPath:indexPath];
    
    NSString *fontFamily = self.fontFamilyArray[indexPath.section];
    NSArray *fontNameArray = [UIFont fontNamesForFamilyName:fontFamily];
    
    NSString *fontName = fontNameArray[indexPath.row];
    
    UILabel *titleLabel = [cell viewWithTag:10];
    UILabel *fontLabel = [cell viewWithTag:11];
    titleLabel.font = [UIFont fontWithName:fontName size:15.0f];
    fontLabel.text = fontName;
    
    return cell;
}


@end
