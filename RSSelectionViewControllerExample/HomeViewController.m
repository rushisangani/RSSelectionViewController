//
//  HomeViewController.m
//  RSSelectionViewControllerExample
//
//  Created by Rushi Sangani on 12/06/16.
//  Copyright © 2016 Rushi Sangani. All rights reserved.
//

#import "HomeViewController.h"
#import "RSSelectionViewController.h"

static NSString *identifier1 =   @"identifier1";
static NSString *identifier2 =   @"identifier2";
static NSString *identifier3 =   @"identifier3";
static NSString *identifier4 =   @"identifier4";
static NSString *identifier5 =   @"identifier5";

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, RSSelectionDelegate>
{
    NSMutableArray *dataArray1;
    NSMutableArray *dataArray2;
    
    NSMutableArray *selectedArray1, *selectedArray2, *selectedArray3, *selectedArray4, *selectedArray5;
}
@end

@implementation HomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
}

#pragma mark- Private methods

-(void)setupData {
    
    dataArray1 = [@[@"Rushi", @"Rahul", @"Raj", @"Axay", @"Jacky", @"Umang", @"Priyanka", @"Payal", @"Megha", @"Ashutosh", @"Sanjay", @"Sagar", @"Mehul", @"Sumit", @"Surbhi", @"Vishal", @"Mac", @"Nimah"] mutableCopy];
    
    dataArray2 = [@[
                    @{@"lastname" : @"Patel"},
                    @{@"lastname" : @"Shah"},
                    @{@"lastname" : @"Jain"},
                    @{@"lastname" : @"Tendulkar"},
                    @{@"lastname" : @"Ganguly"},
                    @{@"lastname" : @"Pandya"},
                    @{@"lastname" : @"Singh"},
                    @{@"lastname" : @"Sharma"},
                    @{@"lastname" : @"Chopra"},
                    @{@"lastname" : @"Kapoor"}
                    
                    ] mutableCopy];
    
    selectedArray1 = [NSMutableArray new];
    selectedArray2 = [NSMutableArray new];
    selectedArray3 = [NSMutableArray new];
    selectedArray4 = [NSMutableArray new];
    selectedArray5 = [NSMutableArray new];
}

#pragma mark- RSSelectionDelegate methods

- (void)getSelectedObjects:(NSArray *)selectedObjects andConcatenatedString:(NSString *)string forIdentifier:(NSString *)identifier {
    
    UITableViewCell *cell;
    
    if([identifier isEqualToString:identifier1]){
        
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [selectedArray1 setArray:selectedObjects];
    }
    else if([identifier isEqualToString:identifier2]){
        
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [selectedArray2 setArray:selectedObjects];
    }
    else if([identifier isEqualToString:identifier3]){

        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [selectedArray3 setArray:selectedObjects];
    }
    else if([identifier isEqualToString:identifier4]){
        
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [selectedArray4 setArray:selectedObjects];
    }
    else if([identifier isEqualToString:identifier5]){
        
        cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [selectedArray5 setArray:selectedObjects];
    }
    
    cell.detailTextLabel.text = string;
}

- (void)getSearchedText:(NSString *)searchedText forIdentifier:(NSString *)identifier {
    NSLog(@"Search text %@", searchedText);
}

#pragma mark- UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self showSingleSelection];
            break;
        
        case 1:
            [self showMultipleSelection];
            break;
            
        case 2:
            [self showSearchWithSelection];
            break;
            
        case 3:
            [self showSearchWithMultipleSelection];
            break;
        
        case 4:
            [self enableEmptySelection];
            break;
        default:
            break;
    }
}

#pragma mark- Custom methods

-(RSSelectionViewController *)getSelectionViewController {
    return [[RSSelectionViewController alloc] initWithNibName:NSStringFromClass([RSSelectionViewController class]) bundle:nil];
}

-(void)showSingleSelection {
    
    RSSelectionViewController *selectionController = [self getSelectionViewController];
    
    [selectionController setDataArray:dataArray1 selectedObjects:selectedArray1 andDelegate:self forIdentifier:identifier1];
    selectionController.navigationTitle = @"Select Name";
    
    [self showSelectionController:selectionController];
}

-(void)showMultipleSelection {
    
    RSSelectionViewController *selectionController = [self getSelectionViewController];
    
    [selectionController setDataArray:dataArray2 selectedObjects:selectedArray2 andDelegate:self forIdentifier:identifier2];

    selectionController.dataAccessKey = @"lastname";
    selectionController.allowMultipleSelection = YES;
    selectionController.navigationTitle = @"Select Lastname";
    
    [self showSelectionController:selectionController];
}

-(void)showSearchWithSelection {
    
    RSSelectionViewController *selectionController = [self getSelectionViewController];
    
    [selectionController setDataArray:dataArray1 selectedObjects:selectedArray3 andDelegate:self forIdentifier:identifier3];
    selectionController.allowSearch = YES;
    selectionController.navigationTitle = @"Select Name";
    selectionController.searchPlaceHolder = @"Search Name";
    
    [self showSelectionController:selectionController];
}

-(void)showSearchWithMultipleSelection {
    
    RSSelectionViewController *selectionController = [self getSelectionViewController];
    
    [selectionController setDataArray:dataArray2 selectedObjects:selectedArray4 andDelegate:self forIdentifier:identifier4];
    
    selectionController.dataAccessKey = @"lastname";
    selectionController.allowMultipleSelection = YES;
    selectionController.allowSearch = YES;
    selectionController.seperator = @" |";
    selectionController.searchPlaceHolder = @"Search Lastname";
    selectionController.searchBar.bottomBorderColor = [UIColor greenColor];
    
    [self showSelectionController:selectionController];
}

-(void)enableEmptySelection {
    
    RSSelectionViewController *selectionController = [self getSelectionViewController];
    
    [selectionController setDataArray:dataArray1 selectedObjects:selectedArray1 andDelegate:self forIdentifier:identifier5];
    
    selectionController.allowEmptySelection = YES;
    selectionController.allowSearch = YES;
    
    [selectionController setNavigationBarTintColor:[[UIColor orangeColor] colorWithAlphaComponent:0.4] titleColor:[UIColor blackColor] andButtonsColor:[UIColor whiteColor]];
    
    [self showSelectionController:selectionController];
}

-(void)showSelectionController:(RSSelectionViewController *)controller {
    [self.navigationController pushViewController:controller animated:YES];
}

@end
