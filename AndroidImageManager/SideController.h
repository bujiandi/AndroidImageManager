//
//  SideController.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "ViewController.h"

@class ViewController;
@interface SideController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (weak, nonatomic) IBOutlet NSOutlineView *outlineView;
@property (weak, nonatomic) ViewController *viewController;

- (void)reloadData;

@end
