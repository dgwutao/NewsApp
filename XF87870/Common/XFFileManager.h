//
//  XFFileManager.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFFileManager : NSObject
+ (BOOL) fileExistsAtPath:(NSString *)path;

+ (NSString*) getDocumentsPath;

+ (BOOL) createDirectoryWithPath:(NSString *)path;

+ (BOOL) removeFileAtPath:(NSString *)filePath;

+ (BOOL) removeFileAtDir:(NSString*)dir name:(NSString*)name;

+ (BOOL) renameFileName:(NSString *)oldName toNewName:(NSString *)newName;

+ (NSData*) readFileContent:(NSString *)filePath;

+ (NSData *)readFileContentFromDir:(NSString*)dir name:(NSString *)name;

+ (BOOL) createFileAtDir:(NSString *)dir data:(NSData *)data name:(NSString *)name;

+ (BOOL) writeToDirectory: (NSString *)dri data:(NSData *)data name:(NSString *)name;

+ (CGFloat) getFileSize:(NSString *)filePath;

+ (CGFloat) getFreeSpace;

+ (NSArray*) getAllPathsWithDir:(NSString*)dir;

@end
