//
//  XFFileCache.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFFileCache.h"

static XFFileCache *_instance = nil;

@implementation XFFileCache

+ (instancetype)sharedInstance {
    XFFileCache *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (NSData*) getFileCacheWithUrl:(NSString*)url
{
    NSString *key = [self generateCacheKeyWithUrl:url];
    NSData *data = [XFFileManager readFileContentFromDir:@"Cache" name:key];
    return data;
}

- (void) setFileCacheWithUrl:(NSString*)url data:(NSData*)data{
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *key = [weakSelf generateCacheKeyWithUrl:url];
        [XFFileManager createFileAtDir:@"Cache" data:data name:key];
    });
}

- (void) clearFileCache
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *paths = [XFFileManager getAllPathsWithDir:@"Cache"];
        for (NSString *name in paths) {
            [XFFileManager removeFileAtDir:@"Cache" name:name];
        }
    });
}

- (NSString*) generateCacheKeyWithUrl:(NSString*)url
{
    NSString *md5Key = [XFUtil getMD5WithNSString:url];
    return md5Key;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}
@end
