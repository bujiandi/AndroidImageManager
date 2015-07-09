//
//  SplitViewController.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/9.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "SplitViewController.h"
#import <objc/runtime.h>

@implementation NSSplitView (Position)

- (CGFloat)position {
    NSNumber *value = objc_getAssociatedObject(self, @selector(position));
    return value.floatValue;
}

- (void)setPosition:(CGFloat)position {
    [self willChangeValueForKey:@"position"];
    objc_setAssociatedObject(self, @selector(position),[NSNumber numberWithFloat:position] , OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"position"];
}

- (void)dealloc {
    objc_removeAssociatedObjects(self);
}

@end

@implementation SplitViewController

- (void)viewDidAppear {
    [super viewDidAppear];
    [self.splitView setPosition:self.splitView.position ofDividerAtIndex:0];
}

@end
