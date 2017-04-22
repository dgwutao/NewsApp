//
//  XFFileCache.h
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFHttpResponseParser.h"

@interface XFFileCache : NSObject<NSCopying, NSMutableCopying>

+ (instancetype)sharedInstance;


- (NSData*) getFileCacheWithUrl:(NSString*)url;
- (void) setFileCacheWithUrl:(NSString*)url data:(NSData*)data;
- (void) clearFileCache;
@end
