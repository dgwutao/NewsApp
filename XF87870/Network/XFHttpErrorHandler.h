//
//  XFHttpErrorHandler.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFHttpErrorHandler : NSObject
+ (void)handleError:(NSError *)error;
+ (void)handleError:(NSError *)error completion:(void (^)(NSDictionary *userInfo)) block;
@end
