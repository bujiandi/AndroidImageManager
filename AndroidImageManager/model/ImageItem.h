//
//  ImageItem.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Appkit/Appkit.h>
#import "File.h"


@interface ImageDateSource : NSObject

+ (instancetype)shared;

@property (nonatomic, strong) NSMutableDictionary *drawables;
@property (nonatomic, strong) NSMutableDictionary *mipmaps;

//@property (nonatomic, strong) NSArray *drawableList;
//@property (nonatomic, strong) NSArray *mipmapList;

@end

@interface ImageItem : NSObject

+ (instancetype)itemWithFile:(File *)file root:(File *)root;
- (instancetype)initWithFile:(File *)file root:(File *)root;

@property (nonatomic, readwrite) File *file;
@property (nonatomic, readonly)  File *root;

@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSImage *image;

@end


@interface File (RootTypeName)

@property (nonatomic, readonly) NSString *imageRootTypeName;

@end