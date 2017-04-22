//
//  XFLoginKit.h
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UserLoginedNotification @"UserLoginedNotification"
#define UserLogoutNotification @"UserLogoutNotification"

@interface XFLoginKit : NSObject

+ (instancetype)sharedLoginKit;

- (BOOL) isLogined;

- (void) loginWithUserName:(NSString*)userName andPassword:(NSString*)password success:(void(^)()) success failure:(void(^)(NSError*)) failure;

- (void) logout:(void(^)())success failure:(void(^)(NSError*)) failure;

- (BOOL) isPhoneNumber:(NSString*)phone;
@end
