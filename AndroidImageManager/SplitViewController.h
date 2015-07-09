//
//  SplitViewController.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/9.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSSplitView (Position)

@property (nonatomic, readwrite) CGFloat position;

@end

@interface SplitViewController : NSSplitViewController

@end
