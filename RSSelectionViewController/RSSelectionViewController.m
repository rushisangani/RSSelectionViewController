//
// RSSelectionViewController.m
//
// Copyright (c) Rushi Sangani.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "RSSelectionViewController.h"

static NSString *kAlertTile                 =   @"Alert!";
static NSString *kOKButtonTitle             =   @"OK";
static NSString *kSelectOneElementMessage   =   @"Please select atleast one row.";
static NSString *cellIdentifier = @"cell";

@interface RSSelectionViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *currentSelectedObjects;       // user's current selected objects
@property (nonatomic, strong) NSMutableArray *searchResultArray;            // array to hold search results

@end

@implementation RSSelectionViewController

#pragma mark- Life Cycle


-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    
    [self initialization];
}

#pragma mark- Setup

-(void)setupViews {
    
    self.title = self.navigationTitle;
    
    // tableView setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // remove unused rows
    self.tableView.tableFooterView = [UIView new];
    
    // add cancel button
    if(!_hideCancelButton){
        [self addCancelButton];
    }
    
    [self setupNavigationBar];
    
    // add search bar if allowSearch is true
    if(self.allowSearch){
        [self addSearchBar];
    }
    
    // add done button for multiple selection
    if(self.allowMultipleSelection && !_hideDoneButton){
        [self addDoneButton];
    }
}

-(void)setupNavigationBar {
    
    if(self.navigationBarColor){
        self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
    }
    
    if(self.titleColor){
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : self.titleColor};
    }
    
    if(self.navigationTintColor){
        self.navigationController.navigationBar.tintColor = self.navigationTintColor;
    }
    
}

-(void)initialization {
 
    self.currentSelectedObjects = [[NSMutableArray alloc] initWithArray:self.selectedObjects copyItems:YES];
    
    // add empty row in data source if not multiple selection
    
    if(self.allowEmptySelection && !self.allowMultipleSelection){
        
        id object = [self.dataArray firstObject];
        
        if([object isKindOfClass:[NSDictionary class]]){
            [self.searchResultArray insertObject:@{_dataAccessKey : @""} atIndex:0];
        }
        else if([object isKindOfClass:[NSString class]]){
            [self.searchResultArray insertObject:@"" atIndex:0];
        }
    }
}

-(void)addDoneButton {
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(void)addCancelButton {
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

-(void)addSearchBar {
    
    self.searchBar = [[RSSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, kDefaultSearchBarHeight) placeHolder:self.searchPlaceHolder font:nil andTextColor:nil];
    
    self.searchBar.tintColor = [[UIColor darkTextColor] colorWithAlphaComponent:0.9];
    self.searchBar.barTintColor = kSearchBarTintColor;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    
    // add search bar to tableHeaderView
    self.tableView.tableHeaderView = self.searchBar;
}

#pragma mark- Public methods

-(void)setDataArray:(NSMutableArray *)array selectedObjects:(NSMutableArray *)selectedObjects andDelegate:(id)delegate forIdentifier:(NSString *)identifier {
    
    self.identifier = identifier;
    self.delegate = delegate;
    self.dataArray = [[NSMutableArray alloc] initWithArray:array];
    self.selectedObjects = selectedObjects;
}

- (void)setNavigationBarTintColor:(UIColor *)barTintColor titleColor:(UIColor *)titleColor andButtonsColor:(UIColor *)tintColor {
    
    self.navigationBarColor = barTintColor;
    self.navigationTintColor = tintColor;
    self.titleColor = titleColor;
}

#pragma mark- Private Methods

/* returns value from object */

-(NSString *)getValueForObject:(id)object {
    
    NSString *value = @"";
    
    if([object isKindOfClass:[NSDictionary class]]){
        value = [object valueForKey:_dataAccessKey];
    }
    else if([object isKindOfClass:[NSString class]]){
        value = object;
    }
    
    return value;
}

/* returns value at indexPath */

-(NSString *)getValueAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = [self.searchResultArray objectAtIndex:indexPath.row];
    return [self getValueForObject:object];
}

/* check if object is already selected */

-(BOOL)isObjectSelectedForIndexPath:(NSIndexPath *)indexPath {
    
    NSString *objectValue = [self getValueAtIndexPath:indexPath];
    
    NSUInteger index = NSNotFound;
    __weak typeof(self) weakSelf = self;
    
     index = [self.currentSelectedObjects indexOfObjectPassingTest:^BOOL(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *selectedValue = [weakSelf getValueForObject:object];
        return ([selectedValue isEqualToString:objectValue]);
    }];
    
    if(index != NSNotFound){
        return YES;
    }
    
    return NO;
}

/* reuturns concatenated string using seperator */

-(NSString *)getConcatenatedStringFromArray:(NSArray *)array {
    
    __block NSMutableString *mutableString = [[NSMutableString alloc] init];
    __weak typeof(self) weakSelf = self;
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *string = [weakSelf getValueForObject:object];
        
        [mutableString appendString:string];
        
        // do not add seperator for last object
        if(idx != array.count - 1){
            [mutableString appendString:[NSString stringWithFormat:@"%@ ",self.seperator]];
        }
        
    }];
    
    return mutableString;
}

-(void)passDataToController {
    
    // replace previous selected array with new array
    [self.selectedObjects setArray:self.currentSelectedObjects];
    
    // get values as concatenated string using seperator from selected objects
    NSString *concatenatedString = [self getConcatenatedStringFromArray:self.selectedObjects];
    
    // pass data
    
    if([self.delegate respondsToSelector:@selector(getSelectedObjects:andConcatenatedString:forIdentifier:)]){
        [self.delegate getSelectedObjects:self.selectedObjects andConcatenatedString:concatenatedString forIdentifier:self.identifier];
    }
    
    if([self.delegate respondsToSelector:@selector(getSearchedText:forIdentifier:)]){
        [self.delegate getSearchedText:self.searchBar.text forIdentifier:self.identifier];
    }
}

-(void)getSearchResultsForSearchString:(NSString *)searchString {
    
    // reset all data if search string is nil
    if([searchString isEqualToString:@""] || !searchString){
        self.searchResultArray = nil;
    }
    else{
        
        [self.searchResultArray removeAllObjects];
        __weak typeof(self) weakSelf = self;
        
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *string = [weakSelf getValueForObject:object];
            
            if([string rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound){
                [self.searchResultArray addObject:object];
            }
        }];
    }
    
    [self.tableView reloadData];
}

#pragma mark- UITableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self getValueAtIndexPath:indexPath];
    
    // display check mark if already selected.
    cell.accessoryType = ([self isObjectSelectedForIndexPath:indexPath]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark- UITableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // for multiple selection
    if(self.allowMultipleSelection){
        
        [self multipleSelectionEventAtIndexPath:indexPath];
    }
    
    // for single selection
    else {
        [self singleSelectionEventAtIndexPath:indexPath];
    }
}

#pragma mark- Event

-(void)dismisViewController {
    
    [self.view endEditing:YES];
    
    if([self isViewControllerPresented]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)singleSelectionEventAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.currentSelectedObjects removeAllObjects];
    
    // if user has selected empty row
    if(indexPath.row == 0 && self.allowEmptySelection){
        
        [self.selectedObjects setArray:self.currentSelectedObjects];
        
        if([self.delegate respondsToSelector:@selector(getSelectedObjects:andConcatenatedString:forIdentifier:)]){
            [self.delegate getSelectedObjects:self.selectedObjects andConcatenatedString:@"" forIdentifier:self.identifier];
        }
    }
    else {
        
        [self.currentSelectedObjects addObject:[self.searchResultArray objectAtIndex:indexPath.row]];
        
        // pass data to previous controller
        [self passDataToController];
    }
    
    // dismiss controller for single selection
    [self dismisViewController];
}

-(void)multipleSelectionEventAtIndexPath:(NSIndexPath *)indexPath {
    
    id selectedObject = [self.searchResultArray objectAtIndex:indexPath.row];
    
    if([self.currentSelectedObjects containsObject:selectedObject]){
        [self.currentSelectedObjects removeObject:selectedObject];
    }
    else {
        [self.currentSelectedObjects addObject:selectedObject];
    }
    
    // Update UI
    [self.tableView reloadData];
}

-(void)doneButtonClicked:(id)sender {
    
    // show alert if empty selection is not allowed and user has selected nothing
    
    if(!self.allowEmptySelection && self.currentSelectedObjects.count == 0){
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:kAlertTile message:kSelectOneElementMessage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:kOKButtonTitle style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else {
        
        // pass data and back to previous controller
        
        [self passDataToController];
        [self dismisViewController];
    }
}

- (void)cancelButtonClicked:(id)sender {
    [self dismisViewController];
}

#pragma mark- SearchBar Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self getSearchResultsForSearchString:searchText];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark- Getter

-(NSString *)navigationTitle {
    
    if(!_navigationTitle){
        _navigationTitle = @"Select";
    }
    return _navigationTitle;
}

-(NSString *)searchPlaceHolder {
    
    if(!_searchPlaceHolder){
        _searchPlaceHolder = @"Search";
    }
    return _searchPlaceHolder;
}

-(NSString *)seperator {
    
    if(!_seperator){
        _seperator = @", ";
    }
    return _seperator;
}

-(NSMutableArray *)searchResultArray {
    
    if(!_searchResultArray){
        _searchResultArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
    }
    return _searchResultArray;
}

-(void)setHideCancelButton:(BOOL)hideCancelButton {
    
    _hideCancelButton = hideCancelButton;
    
    if(hideCancelButton){
        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)setHideDoneButton:(BOOL)hideDoneButton {
    
    _hideDoneButton = hideDoneButton;
    
    if(hideDoneButton){
        self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark- Other methods

-(BOOL)isViewControllerPresented {
    return (self.presentingViewController.presentedViewController == self || [[self.presentingViewController.presentedViewController childViewControllers] firstObject] == self);
}

@end
