//
//  XFMemCache.m
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFMemCache.h"

@interface XFMemCache()
@property (strong, nonatomic) NSCache *cache;

@end


static XFMemCache *_instance = nil;

@implementation XFMemCache

+ (instancetype)sharedInstance {
    XFMemCache *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (id) objectForKey:(NSString*)key
{
    return [self.cache objectForKey:key];
}

- (void) setObjectForKey:(NSString*)key object:(id)object
{
    [self.cache setObject:object forKey:key];
}

- (void) clearAllCache
{
    [self.cache removeAllObjects];
}

- (NSCache*)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc]init];
        _cache.countLimit = 30;
    }
    return _cache;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
