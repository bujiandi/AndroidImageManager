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

@synthesize outlineView = _outlineView;
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
//    [_outlineView sizeLastColumnToFit];
//    [_outlineView reloadItem:nil];
    [_outlineView reloadData];
    //[_outlineView reloadItem:nil reloadChildren:YES];

//    _outlineView.floatsGroupRows = false;
//    
//    [NSAnimationContext beginGrouping];
//    [NSAnimationContext currentContext].duration = 0;
//    [_outlineView expandItem:nil expandChildren:true];
//    [NSAnimationContext endGrouping];
}

@end

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
        NSLog(@"row:%d CELL:%@", index,[item className]);
        return cell;
    }
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    cell.textField.stringValue = item;
    NSLog(@"cell:%@",item);
    return cell;
}

@end
