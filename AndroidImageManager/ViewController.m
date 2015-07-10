//
//  ViewController.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "ViewController.h"
#import "ImageCellView.h"
#import "ImageItem.h"

@interface ViewController () {
    NSMutableArray *_imageItems;
}

@end

@implementation ViewController

@synthesize tableView = _tableView;
@synthesize sideController = _sideController;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)loadData:(NSMutableArray *)imageItems {
    _imageItems = imageItems;
    [_tableView reloadData];

}

@end

@implementation ViewController (NSTableViewDataSource)

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _imageItems.count;
}

/* This method is required for the "Cell Based" TableView, and is optional for the "View Based" TableView. If implemented in the latter case, the value will be set to the view at a given row/column if the view responds to -setObjectValue: (such as NSControl and NSTableCellView).
 */
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSArray *images = _imageItems[row];
    ImageItem *image = images[0];
    return image.name;
}

@end

@implementation ViewController (NSTableViewDelegate)

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSTableCellView *cell = [tableView makeViewWithIdentifier:@"TableCell" owner:self];
    
    
    NSArray *images = _imageItems[row];
    ImageItem *image = images[0];
    
    cell.textField.stringValue = image.name;
    
    return cell;
    
}

@end

/*
#pragma mark - NSOutlineViewDataSource
@implementation ViewController (NSOutlineViewDataSource)

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    return _imageItems.count;
    //NSLog(@"count:%lu",(nil ? 1 : _imageItems.count));
    //return item == nil ? 1 : _imageItems.count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    //if (item == nil) return @"Header";
    NSArray *images = _imageItems[index];
    ImageItem *image = images[0];
    return image.name;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;
{
    return NO;
    //return [outlineView parentForItem:item] == nil;
}

@end


#pragma mark - NSOutlineViewDelegate
@implementation ViewController (NSOutlineViewDelegate)

//- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
//    return NO;
//    //return [outlineView parentForItem:item] == nil;
//}

//- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
//    NSInteger index = [outlineView rowForItem:item];
//    return _imageItems[index];
//}
//
//- (CGFloat)outlineView:(NSOutlineView *)outlineView heightOfRowByItem:(id)item {
//    return 93;
//}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
//    if ([outlineView parentForItem:item] == nil) {
//        NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
//        cell.textField.stringValue = @"Header";
//        return cell;
//    }
    if (![item isKindOfClass:[NSString class]]) {
        NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
        NSInteger index = [outlineView rowForItem:item];
        NSArray *images = _imageItems[index - 1];
        ImageItem *image = images[0];
        cell.textField.stringValue = image.name;
        NSLog(@"row:%ld CELL:%@", (long)index,[item className]);
        return cell;
    }
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
    cell.textField.stringValue = item;
    NSLog(@"cell:%@",item);
    return cell;
}

@end
*/