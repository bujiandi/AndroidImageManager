//
//  ImageItem.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "ImageItem.h"

@interface ImageItem () {
    @private
    //NSImage *_image;
}

@end

@implementation ImageItem

@synthesize file = _file;
@synthesize root = _root;
@synthesize image = _image;

+ (instancetype)itemWithFile:(File *)file root:(File *)root {
    return [[ImageItem alloc] initWithFile:file root:root];
}
- (instancetype)initWithFile:(File *)file root:(File *)root {
    self = [super init];
    if (self) {
        _file = file;
        _root = root;
    }
    return self;
}

- (NSString *)type { return _root.imageRootTypeName; }
- (NSString *)name { return _file.fileName.stringByDeletingPathExtension; }
- (NSImage *)image {
    if (_image == nil) {
        _image = [[NSImage alloc] initWithContentsOfFile:_file.fullPath];
    }
    return _image;
}

- (void)setFile:(File *)file {
    if ([file isEqual:_file]) { return; }
    _file = file;
    _image = nil;
}

- (File *)file { return _file; }
- (File *)root { return _root; }

- (NSString *)description { return [NSString stringWithFormat:@"%@(%@)",_file.fileName, self.type]; }
- (NSString *)debugDescription { return self.description; }

@end
