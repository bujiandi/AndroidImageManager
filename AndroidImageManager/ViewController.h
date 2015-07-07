//
//  ViewController.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SideController;
@interface ViewController : NSViewController <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (weak, nonatomic) IBOutlet NSOutlineView *outlineView;
@property (weak, nonatomic) SideController *sideController;

@end

