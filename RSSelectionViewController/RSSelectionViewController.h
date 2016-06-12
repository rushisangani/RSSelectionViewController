//
// RSSelectionViewController.h
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


#import <UIKit/UIKit.h>
#import "RSSearchBar.h"

@protocol RSSelectionDelegate <NSObject>

@required

-(void)getSelectedObjects:(NSArray *)selectedObjects andConcatenatedString:(NSString *)string forIdentifier:(NSString *)identifier;

@optional

-(void)getSearchedText:(NSString *)searchedText forIdentifier:(NSString *)identifier;

@end

@interface RSSelectionViewController : UIViewController

/* delegate */
@property (nonatomic, weak) id <RSSelectionDelegate> delegate;


/* UITableView */

@property (nonatomic, weak) IBOutlet UITableView *tableView;                // tableView

@property (nonatomic, strong) NSMutableArray *dataArray;                    // data array (datasource for tableview)

@property (nonatomic, strong) NSMutableArray *selectedObjects;              // user's currently selected objects


/* UINavigationBar */

@property (nonatomic, strong) NSString *navigationTitle;                    // title to be shown in navigation bar, default is 'Select'

@property (nonatomic, strong) UIColor *navigationBarColor;                  // navigation bar background color

@property (nonatomic, strong) UIColor *titleColor;                          // title color

@property (nonatomic, strong) UIColor *navigationTintColor;                 // bar button items color

@property (nonatomic, assign) BOOL hideCancelButton;                        // hide cancel button

@property (nonatomic, assign) BOOL hideDoneButton;                          // hide done button


/* UISearchBar */

@property (nonatomic, strong) RSSearchBar *searchBar;                       // search bar

@property (nonatomic, assign) BOOL allowSearch;                             // flag to enable search in tableView, default is 'NO'

@property (nonatomic, strong) NSString *searchPlaceHolder;                  // place holder text for search bar


/* other properties */

@property (nonatomic, strong) NSString *identifier;                         // unique identifier to be passed in delegate

@property (nonatomic, assign) BOOL allowMultipleSelection;                  // flag to enable multiple selection for tableView, default is 'NO'

@property (nonatomic, assign) BOOL allowEmptySelection;                     // flag to enable empty selection for tableView, default is 'NO'

@property (nonatomic, strong) NSString *dataAccessKey;                     // key to access data from dictionary to display in tableview

@property (nonatomic, strong) NSString *seperator;                          // sepetator to be shown between multiple selected values, default is ','


/* public methods */

-(void)setDataArray:(NSMutableArray *)array selectedObjects:(NSMutableArray *)selectedObjects andDelegate:(id)delegate forIdentifier:(NSString *)identifier;

/* configure navigation bar */

-(void)setNavigationBarTintColor:(UIColor *)barTintColor titleColor:(UIColor *)titleColor andButtonsColor:(UIColor *)tintColor;

@end
