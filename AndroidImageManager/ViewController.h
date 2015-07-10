//
//  ViewController.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SideController;
@interface ViewController : NSViewController

@property (weak, nonatomic) IBOutlet NSTableView *tableView;
@property (weak, nonatomic) SideController *sideController;

- (void)loadData:(NSMutableArray *)imageItems;

@end

@interface ViewController (NSTableViewDataSource) <NSTableViewDataSource>

@end

@interface ViewController (NSTableViewDelegate) <NSTableViewDelegate>

@end