//
//  WBFileManager.h
//  ProjectFramework
//
//  Created by zwb on 2018/1/18.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DocumentPath,
    cachesPath,
    TmpPath,
} WBwritetoLocation;

@interface WBFileManager : NSObject
// 根目录
@property(nonatomic, strong) NSString *rootHomePath;
// /Library目录
@property(nonatomic, strong) NSString *libraryPath;
// /Documents目录
@property(nonatomic, strong) NSString *documentPath;
// /caches目录
@property(nonatomic, strong) NSString *cachesPath;
// /preference目录
@property(nonatomic, strong) NSString *preferencesPath;
//  /tmp目录
@property(nonatomic, strong)  NSString *tmpPath;

// MARK: - 创建文件夹到某个目录下 返回文件夹路径
- (NSString *)createDirectoryTo:(WBwritetoLocation)location WithdirectoryName:(NSString *)name;

// MARK: - 创建文件到某个文件夹下 返回整体路径
- (NSString *)createFileTodirectoryPath:(NSString *)directoryPath WithFileName:(NSString *)fileName;

// MARK: - 写入文件 传入文件的路径（包含文件名）
- (void)writeDataTodirectoryPath:(NSString *)directoryPath WithData:(id)data;

// MARK: - 读取文件 传入文件的路径（包含文件名）
- (id)loadDataWithPath:(NSString *)filePath;

// 判断文件是否存在
- (BOOL)isSxistAtPath:(NSString *)filePath;

/**
 移动文件

 @param oldPath 旧的的path
 @param newPath 新的path
 */
- (void)moveFileNameWithOldPath:(NSString *)oldPath toNewPath:(NSString *)newPath ;

- (void)deleteFileWithfileName:(NSString *)fileName;

// 计算文件大小
- (unsigned long long)fileSizeAtPath:(NSString *)filePath;

// 计算整个文件夹中所有文件大小
- (unsigned long long)folderSizeAtPath:(NSString*)folderPath;

- (NSString *)getDocumentFilePathWith:(NSString *)fileName;

- (void)removeremoveItemAtPath:(NSString *)path;
  
@end
