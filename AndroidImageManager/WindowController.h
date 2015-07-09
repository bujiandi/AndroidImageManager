//
//  WindowController.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ViewController;
@class SideController;
@interface WindowController : NSWindowController <NSSplitViewDelegate, NSWindowDelegate>

@property (nonatomic, weak) IBOutlet NSPathControl *pathControl;

@property (nonatomic, weak) ViewController *viewController;
@property (nonatomic, weak) SideController *sideController;

@end
