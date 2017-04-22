//
//  XFCommonFunc.h
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFCommonFunc : NSObject<NSCopying, NSMutableCopying>

+ (instancetype)sharedInstance;

- (void)infoLikeWithCid:(NSString*)cid infoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)commentLikeWithCommentId:(NSString*)commentId success:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)addFavoriteInfoWithCid:(NSString*)cid infoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)deleteFavoriteInfoWithInfoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)subscribeInfoWithCid:(NSString*)cid infoId:(NSString*)infoId adminId:(NSString*)adminId success:(void(^)())success failure:(void(^)(NSError *error))failure;
- (void)unsubscribeInfoWithAdminId:(NSString*)adminId success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
