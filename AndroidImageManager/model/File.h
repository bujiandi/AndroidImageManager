//
//  File.h
//  AndroidImageManager
//
//  Created by 慧趣小歪 on 15/7/7.
//  Copyright (c) 2015年 慧趣小歪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface File : NSObject

#pragma mark 文件路径
@property (strong, nonatomic) NSString *fullPath;

- (void)reloadFileAttributes;

- (NSArray *)subFileList;

@end

#pragma mark - 文件属性
@interface File (Property)

#pragma mark 文件属性
@property (readonly, nonatomic) NSDictionary *fileAttributes;

#pragma mark 文件名称
@property (readonly, nonatomic) NSString *fileName;

#pragma mark 文件扩展名
@property (readonly, nonatomic) NSString *fileExtension;

#pragma mark 文件大小
@property (readonly, nonatomic) unsigned long long fileSize;

@end

@interface File (State)

@property (readonly, nonatomic, getter=isExecutable) BOOL executable;
@property (readonly, nonatomic, getter=isDeletable) BOOL deletable;
@property (readonly, nonatomic, getter=isDirectory) BOOL directory;
@property (readonly, nonatomic, getter=isExists) BOOL exists;

- (BOOL) existsFileName:(NSArray *)fileNames;

@end

#pragma mark - 初始化
@interface File (Init)

- (instancetype) initWithFullPath:(NSString *)fullPath;
- (instancetype) initWithRootPath:(NSString *)rootPath fileName:(NSString *)fileName;
- (instancetype) initWithRootFile:(File *)rootFile fileName:(NSString *)fileName;

+ (instancetype) fileWithFullPath:(NSString *)fullPath;
+ (instancetype) fileWithRootPath:(NSString *)rootPath fileName:(NSString *)fileName;
+ (instancetype) fileWithRootFile:(File *)rootFile fileName:(NSString *)fileName;

@end

#pragma mark - 系统默认路径
@interface File (DefaultPath)

+ (File *)getSystemDirectory:(NSSearchPathDirectory)pathType domainMask:(NSSearchPathDomainMask)domainMask;

+ (NSString *)fullUserName;
+ (NSString *)userName;

+ (File *)documentDirectory;
+ (File *)downloadDirectory;
+ (File *)cacheDirectory;
+ (File *)temporaryDirectory;
+ (File *)openStepRootDirectory;
+ (File *)homeDirectory;
+ (File *)homeDirectoryForUser:(NSString *)userName;

@end