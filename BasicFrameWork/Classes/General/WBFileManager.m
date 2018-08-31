//
//  WBFileManager.m
//  ProjectFramework
//
//  Created by zwb on 2018/1/18.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBFileManager.h"

@implementation WBFileManager
{
    NSFileManager *_fileManager;
}

- (instancetype)init{
    if (self = [super init]) {
        _fileManager = [NSFileManager defaultManager];
    }
    return self;
}

// MARK: - getter && setter

- (NSString *)rootHomePath{
        _rootHomePath = NSHomeDirectory();
    return _rootHomePath;
}

- (NSString *)tmpPath{
        _tmpPath = NSTemporaryDirectory();
    return _tmpPath;
}

- (NSString *)libraryPath{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        _libraryPath = [paths lastObject];
    return _libraryPath;
}

- (NSString *)documentPath{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentPath = [paths lastObject];
    return _documentPath;
}

- (NSString *)cachesPath{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        _cachesPath = [paths lastObject];
    return _cachesPath;
}

- (NSString *)preferencesPath{
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
        _preferencesPath = [paths lastObject];
    return _preferencesPath;
}


// 创建文件夹
- (NSString *)createDirectoryTo:(WBwritetoLocation)location WithdirectoryName:(NSString *)name {
    NSString * directoryPath;
    switch (location) {
        case DocumentPath:
            directoryPath = self.documentPath;
            break;
        case cachesPath:
            directoryPath = self.cachesPath;
            break;
        case TmpPath:
            directoryPath = self.tmpPath;
            break;
        default:
            break;
    }
    NSString *pathName = [directoryPath stringByAppendingPathComponent:name];
   BOOL result = [_fileManager fileExistsAtPath:pathName];
    if (result) {
        NSLog(@"文件夹已经存在");
        return pathName;
    }else{
        BOOL isSuccess = [_fileManager createDirectoryAtPath:pathName withIntermediateDirectories:YES attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"success");
            return pathName;
        } else {
            NSLog(@"fail");
            return nil;
        }
    }
}

// 创建文件
- (NSString *)createFileTodirectoryPath:(NSString *)directoryPath WithFileName:(NSString *)fileName {
    NSString *path = [directoryPath stringByAppendingPathComponent:fileName];
    if ([self isSxistAtPath:path]) {
        NSLog(@"存在");
        return path;
    }else{
        BOOL isSuccess = [_fileManager createFileAtPath:path contents:nil attributes:nil];
        if (isSuccess) {
            return path;
        } else {
            NSLog(@"fail");
            return nil;
        }

    }
}

// 写入文件
- (void)writeDataTodirectoryPath:(NSString *)directoryPath WithData:(NSObject*)data {
//    BOOL isSuccess = [_fileManager createFileAtPath:directoryPath contents:[NSObject conversionToDataWithObj:data] attributes:nil];
//    if (isSuccess) {
//        NSLog(@"write success");
//    } else {
//        NSLog(@"write fail");
//    }
}


- (id)loadDataWithPath:(NSString *)filePath{
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) {
        id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        return obj;
    }
    return nil;
}



//// 读取文件
//- (void)readFile {
//    NSString *documentsPath =[self getDocumentsPath];
//    NSString *iOSPath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
//    NSString *content = [NSString stringWithContentsOfFile:iOSPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"read success: %@",content);
//}

// 判断文件是否存在
- (BOOL)isSxistAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    return isExist;
}

// 计算文件大小
- (unsigned long long)fileSizeAtPath:(NSString *)filePath {
    BOOL isExist = [_fileManager fileExistsAtPath:filePath];
    if (isExist) {
        unsigned long long fileSize = [[_fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
        return fileSize;
    } else {
        NSLog(@"file is not exist");
        return 0;
    }
}

// 计算整个文件夹中所有文件大小
- (unsigned long long)folderSizeAtPath:(NSString*)folderPath {
    BOOL isExist = [_fileManager fileExistsAtPath:folderPath];
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[_fileManager subpathsAtPath:folderPath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = @"";
        while ((fileName = [childFileEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    } else {
        NSLog(@"file is not exist");
        return 0;
    }
}

//// 删除文件
- (void)deleteFileWithfileName:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSuccess = [fileManager removeItemAtPath:fileName error:nil];
    if (isSuccess) {
        NSLog(@"delete success");
    }else{
        NSLog(@"delete fail");
    }
}
//
//// 移动文件
- (void)moveFileNameWithOldPath:(NSString *)oldPath toNewPath:(NSString *)newPath {
    NSError *error;
    BOOL isSuccess = [_fileManager moveItemAtPath:oldPath toPath:newPath error:&error];
    if (isSuccess) {
        NSLog(@"move success");
    }else{
        NSLog(@"rename fail%@",error);
    }
}

//// 重命名
//- (void)renameFileName {
//    //通过移动该文件对文件重命名
//    NSString *documentsPath =[self getDocumentsPath];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"iOS.txt"];
//    NSString *moveToPath = [documentsPath stringByAppendingPathComponent:@"rename.txt"];
//    BOOL isSuccess = [fileManager moveItemAtPath:filePath toPath:moveToPath error:nil];
//    if (isSuccess) {
//        NSLog(@"rename success");
//    }else{
//        NSLog(@"rename fail");
//    }
//}

- (NSString *)getDocumentFilePathWith:(NSString *)fileName{
    
    return [self.documentPath stringByAppendingPathComponent:fileName];
}

- (void)removeremoveItemAtPath:(NSString *)path{
    NSError *error;
    [_fileManager removeItemAtPath:path error:&error];
}

@end
