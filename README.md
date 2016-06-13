# RSSelectionViewController

A very useful control to select items from the list like dropdown in Android.
**RSSelectionViewController** can be used as a ViewController in which user can select single/multiple items, search through the list and get selected item as string to display results.



![Alt text](/Images/image1.png?raw=true "Single Selection")       ![Alt text](/Images/image2.png?raw=true "Multiple Selection")



![Alt text](/Images/image3.png?raw=true "Search")                 ![Alt text](/Images/image4.png?raw=true "Customize Theme")



## Features

- Present/Push/PopOver RSSelectionViewController as per need.
- Enable multiple selection using single property **allowMultipleSelection**.
- Enable search funtionality using single property **allowSearch**.
- Allow empty selection when you don't want to select anything by using single property **allowEmptySelection**.
- Customizable NavigationBar, and Buttons color etc.
- Customizable SarchBar place holder, color etc.
- Get selected items as a string to display using delegate method.


## How To Use

### Single Selection

```objective-c
RSSelectionViewController *selectionController = [[RSSelectionViewController alloc] initWithNibName:NSStringFromClass([RSSelectionViewController class]) bundle:nil];

/* pass array as a dataSource, array of selected objects if any and identifier if required */
[selectionController setDataArray:dataArray selectedObjects:selectedArray andDelegate:self forIdentifier:identifier];

/* set title if required */
selectionController.navigationTitle = @"Select Name";

[self.navigationController pushViewController:selectionController animated:YES];
```

### Multiple Selection

```objective-c
RSSelectionViewController *selectionController = [[RSSelectionViewController alloc] initWithNibName:NSStringFromClass([RSSelectionViewController class]) bundle:nil];

/* pass array as a dataSource, array of selected objects if any and identifier if required */
[selectionController setDataArray:dataArray selectedObjects:selectedArray andDelegate:self forIdentifier:identifier];

/* pass keyname to display roe title if dataArray contains dictionary */
selectionController.dataAccessKey = @"key_name";

/* enable multiple selection */
selectionController.allowMultipleSelection = YES;

/* set custom seperator */
selectionController.seperator = @" |";

[self.navigationController pushViewController:selectionController animated:YES];
```

### Selection with Search

```objective-c
RSSelectionViewController *selectionController = [[RSSelectionViewController alloc] initWithNibName:NSStringFromClass([RSSelectionViewController class]) bundle:nil];

/* pass array as a dataSource, array of selected objects if any and identifier if required */
[selectionController setDataArray:dataArray selectedObjects:selectedArray andDelegate:self forIdentifier:identifier];

/* set title if required */
selectionController.navigationTitle = @"Select Name";

/* enable search */
selectionController.allowSearch = YES;

/* set searchBar placeholder if required */
selectionController.searchPlaceHolder = @"Search Name";

[self.navigationController pushViewController:selectionController animated:YES];
```

### Get Selected Data using delegate method

```objective-c
#pragma mark- RSSelectionDelegate methods

- (void)getSelectedObjects:(NSArray *)selectedObjects andConcatenatedString:(NSString *)string forIdentifier:(NSString *)identifier {
    
    /* replace previous selected objects with new objects */
    [selectedArray setArray:selectedObjects];
    
    /* display selected objects as a concatenated string */
    self.label.text = string;
}

- (void)getSearchedText:(NSString *)searchedText forIdentifier:(NSString *)identifier {
    // get text typed in searchBar 
}
```


## License

RSSelectionViewController is released under the MIT license. See LICENSE for details.


