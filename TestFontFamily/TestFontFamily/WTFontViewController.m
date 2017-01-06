//
//  WTFontViewController.m
//  TestFontFamily
//
//  Created by fanghao on 2017/1/5.
//  Copyright © 2017年 fanghao. All rights reserved.
//

#import "WTFontViewController.h"

@interface WTFontViewController ()

@property (nonatomic, strong) NSMutableArray *fontIndexArray;

@property (nonatomic, strong) NSMutableDictionary *fontdictionary;

@end

@implementation WTFontViewController

#pragma mark - getters

- (NSMutableArray *)fontIndexArray
{
    if (!_fontIndexArray) {
        _fontIndexArray = [[NSMutableArray alloc] init];
    }
    return _fontIndexArray;
}


- (NSMutableDictionary *)fontdictionary
{
    if (!_fontdictionary) {
        _fontdictionary = [[NSMutableDictionary alloc] init];
    }
    return _fontdictionary;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 70.0f;
    
    for (NSString *fontFamily in [UIFont familyNames]) {
        NSArray *fontNameArray = [UIFont fontNamesForFamilyName:fontFamily];
        for (NSString *fontName in fontNameArray) {
            
            NSString *firstLetter = [[fontName substringToIndex:1] uppercaseString];
            
            NSMutableArray *fontArray = [[NSMutableArray alloc] initWithArray:self.fontdictionary[firstLetter]] ;
            [fontArray addObject:fontName];
            [self.fontdictionary setValue:fontArray forKey:firstLetter];
            
            //[self.fontNameArray  addObject:fontName];
        }
    }
    
   NSArray *fontIndexArray = [[self.fontdictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *  _Nonnull obj1, NSString *  _Nonnull obj2) {
        if (obj1 > obj2) {
            return NSOrderedDescending;
        }else{
            return NSOrderedAscending;
        }
    }];
    [self.fontIndexArray addObjectsFromArray:fontIndexArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fontdictionary allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *firstLetter = self.fontIndexArray[section];
    NSArray *fontArray = self.fontdictionary[firstLetter];
    return fontArray.count;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.fontIndexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *firstLetter = self.fontIndexArray[section];
    return firstLetter;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *firstLetter = self.fontIndexArray[indexPath.section];
    NSArray *fontArray = self.fontdictionary[firstLetter];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fontCell" forIndexPath:indexPath];
    
    NSString *fontName = fontArray[indexPath.row];
    
    UILabel *titleLabel = [cell viewWithTag:10];
    UILabel *fontLabel = [cell viewWithTag:11];
    titleLabel.font = [UIFont fontWithName:fontName size:15.0f];
    fontLabel.text = fontName;
    
    return cell;
}


@end
