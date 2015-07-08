//
//  ImageItem.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "ImageItem.h"

static ImageDateSource *_instance;

@implementation ImageDateSource

+ (instancetype)shared {
    @synchronized(self) {
        if (_instance == nil) {
            _instance = [[ImageDateSource alloc] init];
        }
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        if (_instance == nil) {
            return [super allocWithZone:zone];
        }
    }
    return _instance;
}

- (id)copy { return _instance; }

- (instancetype)init {
    @synchronized(self) {
        if (_instance == nil) {
            self = [super init];
            if (self) {
                _drawableList = @[];
                _mipmapList = @[];
                _drawables = [NSMutableDictionary dictionary];
                _mipmaps = [NSMutableDictionary dictionary];
            }
            _instance = self;
        }
    }
    return _instance;
}

@synthesize drawableList = _drawableList;
@synthesize mipmapList = _mipmapList;
@synthesize drawables = _drawables;
@synthesize mipmaps = _mipmaps;

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
