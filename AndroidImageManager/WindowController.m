//
//  WindowController.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "WindowController.h"
#import "SplitViewController.h"
#import "SideController.h"
#import "ViewController.h"

#import "File.h"

#import "ImageItem.h"


@interface WindowController ()

@end

@implementation WindowController

- (CGFloat)splitView:(NSSplitView *)splitView constrainSplitPosition:(CGFloat)proposedPosition ofSubviewAt:(NSInteger)dividerIndex {
    splitView.position = proposedPosition < 250 ? 250 : proposedPosition;
    return splitView.position;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.window setFrame:NSMakeRect(1000, 500, 800, 180) display:false];
    
    SplitViewController *splitController = (SplitViewController *)self.contentViewController;
    
    splitController.splitView.position = 300;
    splitController.splitView.delegate = self;
    [splitController.splitView setHoldingPriority:300 forSubviewAtIndex:0];
    
    
    _sideController = (SideController *)((NSSplitViewItem *)splitController.splitViewItems[0]).viewController;
    _viewController = (ViewController *)((NSSplitViewItem *)splitController.splitViewItems[1]).viewController;
   
    _sideController.viewController = _viewController;
    _viewController.sideController = _sideController;
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [self loadAndroidProjectPath:@"/Users/bujiandi/Documents/Android/ExamReader/reader"];
}

- (void)loadAndroidProjectPath:(NSString *)path {
    if (path.length == 0) return;
    
    File *rootFile = [File fileWithFullPath:path];
    if (!rootFile.isDirectory) return;
    
    if ([self existsProject:rootFile]) {
        [self loadAndroidProjectImages:rootFile];
        return;
    }
    
    for (File *file in rootFile.subFileList) {
        if ([self existsProject:file]) {
            [self loadAndroidProjectImages:file];
            return;
        }
    }
    //
}

- (BOOL)existsProject:(File *)rootFile {
    if (!rootFile.isDirectory) return NO;
    return [rootFile existsFileName:@[@"src", @"libs", @"build"]];
}

- (void)loadAndroidProjectImages:(File *)rootFile {
    File *resFile = [File fileWithRootFile:rootFile fileName:@"src/main/res"];
    
    NSArray * drawableList = @[
                               [File fileWithRootFile:resFile fileName:@"drawable"],
                               [File fileWithRootFile:resFile fileName:@"drawable-ldpi"],
                               [File fileWithRootFile:resFile fileName:@"drawable-mdpi"],
                               [File fileWithRootFile:resFile fileName:@"drawable-hdpi"],
                               [File fileWithRootFile:resFile fileName:@"drawable-xhdpi"],
                               [File fileWithRootFile:resFile fileName:@"drawable-xxhdpi"],
                               [File fileWithRootFile:resFile fileName:@"drawable-xxxhdpi"]
                               ];
    NSArray * mipmapList = @[
                             [File fileWithRootFile:resFile fileName:@"mipmap"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-ldpi"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-mdpi"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-hdpi"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-xhdpi"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-xxhdpi"],
                             [File fileWithRootFile:resFile fileName:@"mipmap-xxxhdpi"]
                             ];
    
    NSArray *fileExtensions = @[@"png", @"jpg", @"jpeg"];
    
    [ImageDateSource shared].drawables = [NSMutableDictionary dictionary];
    for (File *drawable in drawableList) {
        BOOL isDirectory;
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:drawable.fullPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory) continue;
        for (File *file in drawable.subFileList) {
            BOOL isImage = NO;
            NSString *fileExtension = file.fileExtension;
            for (NSString *extension in fileExtensions)
                isImage |= [fileExtension isEqualToString:extension];
            if (!isImage) continue;
            NSString *name = file.fileName.stringByDeletingPathExtension;
            ImageItem *item = [[ImageItem alloc] initWithFile:file root:drawable];
            NSMutableArray *drawables = [ImageDateSource shared].drawables[name];
            if (drawables == nil) {
                drawables = [NSMutableArray array];
            }
            [drawables addObject:item];
            [ImageDateSource shared].drawables[name] = drawables;
        }
    }
    
    
    [ImageDateSource shared].mipmaps = [NSMutableDictionary dictionary];
    for (File *mipmap in mipmapList) {
        BOOL isDirectory;
        BOOL isExists = [[NSFileManager defaultManager] fileExistsAtPath:mipmap.fullPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory) continue;
        for (File *file in mipmap.subFileList) {
            BOOL isImage = NO;
            NSString *fileExtension = file.fileExtension;
            for (NSString *extension in fileExtensions)
                isImage |= [fileExtension isEqualToString:extension];
            if (!isImage) continue;
            NSString *name = file.fileName.stringByDeletingPathExtension;
            ImageItem *item = [[ImageItem alloc] initWithFile:file root:mipmap];
            NSMutableArray *mipmaps = [ImageDateSource shared].mipmaps[name];
            if (mipmaps == nil) {
                mipmaps = [NSMutableArray array];
            }
            [mipmaps addObject:item];
            [ImageDateSource shared].mipmaps[name] = mipmaps;
        }
    }
    
    [_sideController reloadData];
}

@end
