//
//  XFMemCache.h
//  XF87870
//
//  Created by xf on 2016/12/2.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFMemCache : NSObject<NSCopying, NSMutableCopying>

+ (instancetype)sharedInstance;

- (id) objectForKey:(NSString*)key;

- (void) setObjectForKey:(NSString*)key object:(id)object;

- (void) clearAllCache;

@end
