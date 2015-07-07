//
//  File.m
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import "File.h"
#import "NSString+Util.h"

@interface File () {
    @private
    NSDictionary *_fileAttributes;
}

@end

@implementation File
@synthesize fullPath = _fullPath;

- (void)setFullPath:(NSString *)fullPath {
    _fullPath = fullPath;
    [self reloadFileAttributes];
}

// 文件路径
- (NSString *)fullPath { return _fullPath; }

- (void)reloadFileAttributes {
    NSError *error;

    _fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:_fullPath error:&error];
    if (_fileAttributes == nil) {
        _fileAttributes = [NSDictionary dictionary];
    }
}

- (NSArray *)subFileList {
    NSMutableArray *files = [NSMutableArray array];
    NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_fullPath error:nil];
    
    for (NSString *fileName in fileNames) {
        [files addObject:[File fileWithRootFile:self fileName:fileName]];
    }
    return files;
}

- (NSString *)description { return self.fileName; }
- (NSString *)debugDescription { return self.fullPath; }

- (BOOL)isEqual:(id)object {
    if (object == nil) {
        return NO;
    } else if ([object isKindOfClass:[File class]]) {
        return [((File *)object).fullPath isEqualToString:_fullPath];
    }
    return [super isEqual:object];
}

@end

#pragma mark - 文件属性
@implementation File (Property)

// 文件属性
- (NSDictionary *)fileAttributes { return _fileAttributes; }

// 文件名称
- (NSString *)fileName { return [_fullPath stringByDeletingPathPrefix]; }

// 文件扩展名
- (NSString *)fileExtension { return [self.fileName componentsSeparatedByString:@"."].lastObject; }

// 文件大小
- (unsigned long long)fileSize { return ((NSNumber *)_fileAttributes[NSFileSize]).unsignedLongLongValue; }

@end

#pragma mark - 文件状态
@implementation File (State)

- (BOOL)isExecutable { return [[NSFileManager defaultManager] isExecutableFileAtPath:_fullPath]; }

- (BOOL)isDeletable { return [[NSFileManager defaultManager] isDeletableFileAtPath:_fullPath]; }

- (BOOL)isExists { return [[NSFileManager defaultManager] fileExistsAtPath:_fullPath]; }

- (BOOL)isDirectory {
    BOOL directory;
    [[NSFileManager defaultManager] fileExistsAtPath:_fullPath isDirectory:&directory];
    return directory;
}


- (BOOL) existsFileName:(NSArray *)names {
    if (names.count == 0) return NO;
    
    NSMutableArray *filterNames = [NSMutableArray arrayWithArray:names];
    
    NSArray *fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_fullPath error:nil];
    
    for (NSString *fileName in fileNames) {
        if (filterNames.count == 0) break;
        NSString *filterName = nil;
        for (NSString *name in filterNames) {
            if ([name isEqualToString:fileName]) {
                filterName = name;
                break;
            }
        }
        if (filterName != nil) { [filterNames removeObject:filterName]; }
    }
    
    return filterNames.count == 0;
}



@end

#pragma mark - 文件初始化
@implementation File (Init)

- (instancetype)initWithFullPath:(NSString *)fullPath {
    self = [super init];
    if (self) {
        [self setFullPath:fullPath];
    }
    return self;
}

- (instancetype)initWithRootPath:(NSString *)rootPath fileName:(NSString *)fileName {
    self = [self initWithFullPath:[rootPath stringByAppendingPathComponent:fileName]];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithRootFile:(File *)rootFile fileName:(NSString *)fileName {
    
    self = [self initWithFullPath:[rootFile.fullPath stringByAppendingPathComponent:fileName]];
    if (self) {
        
    }
    return self;
}

+ (instancetype)fileWithFullPath:(NSString *)fullPath {
    return [[File alloc] initWithFullPath:fullPath];
}

+ (instancetype)fileWithRootPath:(NSString *)rootPath fileName:(NSString *)fileName {
    return [[File alloc] initWithRootPath:rootPath fileName:fileName];
}

+ (instancetype)fileWithRootFile:(File *)rootFile fileName:(NSString *)fileName {
    return [[File alloc] initWithRootFile:rootFile fileName:fileName];
}

@end

#pragma mark - 系统默认路径

@implementation File (DefaultPath)

+ (File *)getSystemDirectory:(NSSearchPathDirectory)pathType domainMask:(NSSearchPathDomainMask)domainMask {
    NSString *path = NSSearchPathForDirectoriesInDomains(pathType, domainMask, true)[0];
    return [File fileWithFullPath:path];
}

+ (NSString *)userName { return NSUserName(); }
+ (NSString *)fullUserName { return NSFullUserName(); }

+ (File *)documentDirectory { return [File getSystemDirectory:NSDocumentDirectory domainMask:NSUserDomainMask]; }
+ (File *)downloadDirectory { return [File getSystemDirectory:NSDownloadsDirectory domainMask:NSUserDomainMask]; }
+ (File *)cacheDirectory { return [File getSystemDirectory:NSCachesDirectory domainMask:NSUserDomainMask]; }
+ (File *)temporaryDirectory { return [File fileWithFullPath:NSTemporaryDirectory()]; }
+ (File *)openStepRootDirectory { return [File fileWithFullPath:NSOpenStepRootDirectory()]; }
+ (File *)homeDirectory { return [File fileWithFullPath:NSHomeDirectory()]; }
+ (File *)homeDirectoryForUser:(NSString *)userName {
    NSString *path = NSHomeDirectoryForUser(userName);
    if (path == nil) {
        path = NSHomeDirectory();
    }
    return [File fileWithFullPath:path];
}

@end
