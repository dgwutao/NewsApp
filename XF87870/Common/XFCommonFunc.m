//
//  XFCommonFunc.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFCommonFunc.h"
#import "XFHttpRequestManger.h"
#import "XFHttpResponseParser.h"

@interface XFCommonFunc()
@property (strong, nonatomic) XFHttpRequestManger *sessionManager;

@end

static XFCommonFunc *_instance = nil;

@implementation XFCommonFunc

+ (instancetype)sharedInstance {
    XFCommonFunc *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (void)infoLikeWithCid:(NSString*)cid infoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"cid":cid,
                             @"id":infoId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:InfoLike
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)commentLikeWithCommentId:(NSString*)commentId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"id":commentId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:CommentLike
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)addFavoriteInfoWithCid:(NSString*)cid infoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"cid":cid,
                             @"id":infoId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:AddFavoriteInfo
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)deleteFavoriteInfoWithInfoId:(NSString*)infoId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"id":infoId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:DeleteFavoriteInfo
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)subscribeInfoWithCid:(NSString*)cid infoId:(NSString*)infoId adminId:(NSString*)adminId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"cid":cid,
                             @"id":infoId,
                             @"adminid":adminId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:AddFavoriteAdminInfo
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (void)unsubscribeInfoWithAdminId:(NSString*)adminId success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    NSDictionary *params = @{@"adminid":adminId,
                             @"uid":DefaultUid};
    [self.sessionManager
     sendGetHttpRequestWithUrl:DeleteFavoriteAdminInfo
     params:params parser:[XFHttpResponseParser sharedParser].UserActionParser progress:nil
     success:^(id response) {
         if (success) {
             success();
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}

- (XFHttpRequestManger*) sessionManager{
    if (!_sessionManager) {
        _sessionManager = [[XFHttpRequestManger alloc]init];
    }
    return _sessionManager;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

@end
