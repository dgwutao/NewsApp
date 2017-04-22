//
//  XFFileManager.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFFileManager.h"

#define DocumentsPath [self getDocumentsPath]

static NSString *_documentDirectory;

@implementation XFFileManager

+ (BOOL) fileExistsAtPath:(NSString *)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (NSString*) getDocumentsPath
{
    if (!_documentDirectory) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentDirectory = [paths firstObject];
    }
    return _documentDirectory;
}

+ (BOOL) createDirectoryWithPath:(NSString *)path
{
    BOOL result = NO;
    NSString *dir = [DocumentsPath stringByAppendingPathComponent:path];
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        result = YES;
    }else{
        NSError *error;
        result = [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:NO attributes:nil error:&error];
        if (error) {
            DebugLog(@"创建目录失败：%@",[error localizedDescription]);
        }
    }
    return result;
}

+ (BOOL) removeFileAtPath:(NSString *)filePath
{
    BOOL result = NO;
    NSString *fullPath = [DocumentsPath stringByAppendingPathComponent:filePath];
    if ([self fileExistsAtPath:fullPath]) {
        NSError *error;
        result = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
        if (error){
            DebugLog(@"删除失败：%@",[error localizedDescription]);
        }
    }
    return result;
}

+ (BOOL) removeFileAtDir:(NSString*)dir name:(NSString*)name
{
    BOOL result = NO;
    NSString *fullPath = [DocumentsPath stringByAppendingPathComponent:[dir stringByAppendingPathComponent:name]];
    if ([self fileExistsAtPath:fullPath]) {
        NSError *error;
        result = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
        if (error){
            DebugLog(@"删除失败：%@",[error localizedDescription]);
        }
    }
    return result;
}

+ (BOOL) renameFileName:(NSString*)oldName toNewName:(NSString *)newName
{
    BOOL result = NO;
    NSError *error;
    result = [[NSFileManager defaultManager] moveItemAtPath:[DocumentsPath stringByAppendingPathComponent:oldName] toPath:[DocumentsPath stringByAppendingPathComponent:newName] error:&error];
    if (error) {
        DebugLog(@"重命名失败：%@",[error localizedDescription]);
    }
    return result;
}

+ (NSData *) readFileContent:(NSString *)filePath
{
    return [[NSFileManager defaultManager] contentsAtPath:[DocumentsPath stringByAppendingPathComponent:filePath]];
}

+ (NSData *) readFileContentFromDir:(NSString*)dir name:(NSString *)name
{
    return [[NSFileManager defaultManager] contentsAtPath:[DocumentsPath stringByAppendingPathComponent:[dir stringByAppendingPathComponent:name]]];
}

+ (BOOL) createFileAtDir:(NSString *)dir data:(NSData *)data name:(NSString *)name
{
    BOOL dirExist = [self createDirectoryWithPath:dir];
    if (dirExist) {
        NSString *fullPath = [DocumentsPath stringByAppendingPathComponent:[dir stringByAppendingPathComponent:name]];
        if ([self fileExistsAtPath:fullPath]) {
            [self removeFileAtPath:fullPath];
        }
        if ([self getFreeSpace] - 1000 > data.length) {
            return [[NSFileManager defaultManager] createFileAtPath:fullPath contents:data attributes:nil];
        }
    }
    return NO;
}

+ (BOOL) writeToDirectory:(NSString *)dir data:(NSData *)data name:(NSString *)name
{
    BOOL dirExist = [self createDirectoryWithPath:dir];
    if (dirExist) {
        NSString *fullPath = [DocumentsPath stringByAppendingPathComponent:[dir stringByAppendingPathComponent:name]];
        if ([self fileExistsAtPath:fullPath]) {
            [self removeFileAtPath:fullPath];
        }
        if ([self getFreeSpace] - 1000 > data.length) {
            NSError *error;
            BOOL result = [data writeToFile:fullPath options:NSDataWritingFileProtectionNone error:&error];
            if (error) {
                DebugLog(@"分拣写入失败：%@",[error localizedDescription]);
            }
            return result;
        }
    }
    return NO;
}

+ (CGFloat) getFileSize:(NSString *)filePath
{
    NSError *error;
    NSDictionary *attributes = [NSDictionary dictionaryWithDictionary:[[NSFileManager defaultManager] attributesOfItemAtPath:[DocumentsPath stringByAppendingPathComponent:filePath] error:&error]];
    if (attributes){
        return [[attributes objectForKey:NSFileSize] doubleValue];
    }
    if (error) {
        DebugLog(@"计算文件大小失败：%@",[error localizedDescription]);
    }
    return 0;
}

+ (CGFloat) getFreeSpace
{
    NSString *path = DocumentsPath;
    NSDictionary *fileSysAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    return freeSpace.doubleValue;
}

+ (NSArray*) getAllPathsWithDir:(NSString*)dir
{
    NSString *fullPath = [DocumentsPath stringByAppendingPathComponent:dir];
    return [[NSFileManager defaultManager] subpathsAtPath:fullPath];
}

@end
