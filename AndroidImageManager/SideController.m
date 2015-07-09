//
//  SideController.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "SideController.h"
#import "ViewController.h"
#import "ImageItem.h"

@interface SideController () {
    @private
    NSArray *_headers;
}

@end

@implementation SideController
@synthesize outlineView = _outlineView;
@synthesize viewController = _viewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headers = @[@"drawable", @"mipmap"];
    
    [_outlineView sizeLastColumnToFit];
    _outlineView.floatsGroupRows = false;
    
    [NSAnimationContext beginGrouping];
    [NSAnimationContext currentContext].duration = 0;
    [_outlineView expandItem:nil expandChildren:true];
    [NSAnimationContext endGrouping];
    // Do view setup here.
}

- (void)reloadData {
    [_outlineView sizeLastColumnToFit];
    [_outlineView reloadData];
    _outlineView.floatsGroupRows = false;
    
    [NSAnimationContext beginGrouping];
    [NSAnimationContext currentContext].duration = 0;
    [_outlineView expandItem:nil expandChildren:true];
    [NSAnimationContext endGrouping];
}

@end


#pragma mark - NSOutlineViewDataSource
@implementation SideController (NSOutlineViewDataSource)

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return _headers.count;
    }
    NSDictionary *dict = [outlineView rowForItem:item] == 0 ? [ImageDateSource shared].drawables : [ImageDateSource shared].mipmaps;
    return dict.count;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return _headers[index];
    }
    NSDictionary *dict = [outlineView rowForItem:item] == 0 ? [ImageDateSource shared].drawables : [ImageDateSource shared].mipmaps;
    return dict.allKeys[index];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item;
{
    return [outlineView parentForItem:item] == nil;
}

@end

#pragma mark - NSOutlineViewDelegate
@implementation SideController (NSOutlineViewDelegate)

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return [outlineView parentForItem:item] == nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    return [outlineView parentForItem:item] != nil;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return item;
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    if ([outlineView parentForItem:item] == nil) {
        NSInteger index = [outlineView rowForItem:item] == 0 ? 0 : 1;
        NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
        cell.textField.stringValue = _headers[index];
        return cell;
    }
    NSInteger parentRow = [outlineView rowForItem:[outlineView parentForItem:item]];
    NSInteger currentRow = [outlineView rowForItem:item];
    NSInteger index = currentRow - parentRow - 1;
    
    NSDictionary *dict = parentRow == 0 ? [ImageDateSource shared].drawables : [ImageDateSource shared].mipmaps;
    
    NSString *key = dict.allKeys[index];
    NSArray *images = dict[key];
    ImageItem *image = images[0];
    NSString *path = image.file.fullPath;
    
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    cell.textField.stringValue = item;
    cell.imageView.image = [[NSImage alloc] initWithContentsOfFile:path];
    return cell;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSOutlineView *outlineView = notification.object;
    
    NSMutableArray *imageItems = [NSMutableArray array];
    [outlineView.selectedRowIndexes enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
        NSString *item = [outlineView itemAtRow:row];
        NSDictionary *dict = [outlineView rowForItem:[outlineView parentForItem:item]] == 0 ? [ImageDateSource shared].drawables : [ImageDateSource shared].mipmaps;
        NSArray *images = dict[item];
        if (images != nil) [imageItems addObject:images];
        NSLog(@"item:%@",item);
    }];

    [_viewController loadData:imageItems];
}

@end
