//
//  XFHttpRequest.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFHttpRequestManger.h"
#import "XFHttpErrorHandler.h"
#import "XFAppScret.h"

@interface XFHttpRequestManger()
@property (strong, nonatomic) AFHTTPSessionManager *session;
@end

@implementation XFHttpRequestManger

- (instancetype) init{
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30.0f;
        _session = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _session.operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
        _session.responseSerializer = [AFHTTPResponseSerializer serializer];
        _session.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSSet *sets = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",@"image/png",@"image/jpeg",@"charset=utf-8", nil];
        _session.responseSerializer.acceptableContentTypes =  [_session.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:sets];
    }
    return self;
}

- (void) sendGetHttpRequestWithUrl:(NSString*)url
                            params:(NSDictionary*) parameters
                            parser:(responseParser)parser
                          progress:(void(^)(NSProgress *progressValue)) progress
                           success:(void (^)(id response)) success
                           failure:(void(^)(NSError *error)) failure{
    NSDictionary *finalParams = [self geneFinalParams:parameters];
    __weak typeof (self) weakSelf = self;
    [self.session GET:[NSString stringWithFormat:@"%@%@",RootUrl,url] parameters:finalParams
             progress:^(NSProgress * _Nonnull downloadProgress) {
                 if (progress) {
                     progress(downloadProgress);
                 }
             }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 DebugLog(@"-------------------返回URL：%@", task.currentRequest.URL);
                 NSError *error;
                 DebugLog(@"-------------------返回RESULT：%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
                 NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                 if (json && [[[json objectForKey:@"result"] objectForKey:@"ret"] isEqualToString:@"0"]) {
                     if (success) {
                         id result = parser(json);
                         success(result);
                     }
//                     [[XFFileCache sharedInstance]setFileCacheWithUrl:[weakSelf getPersistenceUrlKey:url params:finalParams] data:responseObject];
                 }else{
                     if (failure) {
                         if (!error) {
                             error = [NSError errorWithDomain:task.currentRequest.URL.absoluteString code:[[[json objectForKey:@"result"] objectForKey:@"ret"] integerValue] userInfo:nil];
                         }
                         [XFHttpErrorHandler handleError:error];
                         failure(error);
                     }
                 }
             }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 DebugLog(@"-------------------返回URL：%@", task.currentRequest.URL);
                 [XFHttpErrorHandler handleError:error];
//                 NSData *data = [[XFFileCache sharedInstance] getFileCacheWithUrl:[weakSelf getPersistenceUrlKey:url params:finalParams]];
//                 if (data) {
//                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                     if (success) {
//                         id result = parser(json);
//                         success(result);
//                     }
//                 }else{
                     if (failure){
                         failure(error);
                     }
//                 }
             }];
}

- (void) sendPostHttpRequestWithUrl:(NSString*)url
                             params:(NSDictionary*) parameters
                          bodyBlock:(void (^)(id <AFMultipartFormData> formData))dataBlock
                           progress:(void(^)(NSProgress *progressValue)) progress
                            success:(void (^)(NSDictionary *response)) success
                            failure:(void(^)(NSError *error)) failure{
    NSDictionary *finalParams = [self geneFinalParams:parameters];
    [self.session POST:[NSString stringWithFormat:@"%@%@",RootUrl,url] parameters:finalParams
constructingBodyWithBlock:dataBlock
              progress:^(NSProgress * _Nonnull uploadProgress) {
                  if (progress) {
                      progress(uploadProgress);
                  }
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  DebugLog(@"-------------------请求URL：%@", task.currentRequest.URL);
                  NSError *error;
                  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
                  DebugLog(@"-------------------返回RESULT：%@", [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
                  if (json) {
                      if (success) {
                          success(json);
                      }
                  }else{
                      if (failure) {
                          failure(error);
                      }
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  DebugLog(@"-------------------请求URL：%@", task.currentRequest.URL);
                  [XFHttpErrorHandler handleError:error];
                  if (failure) {
                      failure(error);
                  }
              }];
}

- (NSDictionary*) geneFinalParams:(NSDictionary*)params
{
    NSMutableDictionary *finalParams = [NSMutableDictionary dictionaryWithDictionary:params];
    [finalParams setObject:[NSString stringWithCString:getAppId() encoding:NSUTF8StringEncoding] forKey:@"appid"];
    [finalParams setObject:[XFUtil getTimestamp] forKey:@"timespan"];
//    NSString *ipAddress = [XFUtil getIPAddress];
//    if (ipAddress && ipAddress.length > 0) {
//        [finalParams setObject:ipAddress forKey:@"clientIp"];
//    }
    [finalParams setObject:@"json" forKey:@"restype"];
//    [finalParams setObject:@"87870" forKey:@"zparam"];
    [finalParams setObject:[NSString stringWithCString:getAppSecret() encoding:NSUTF8StringEncoding] forKey:@"appsecret"];
    NSArray *allKeys = [finalParams allKeys];
    NSArray *sortedKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableString *rawSign = [NSMutableString new];
    for (NSString *key in sortedKeys) {
        [rawSign appendString:[finalParams objectForKey:key]];
    }
    NSString *md5Sign = [XFUtil getMD5WithNSString:rawSign];
    [finalParams setObject:md5Sign forKey:@"sign"];
    [finalParams removeObjectForKey:@"appsecret"];
    return finalParams;
}

- (NSString*) getPersistenceUrlKey:(NSString*)url params:(NSDictionary*)params
{
    NSArray *allKeys = params.allKeys;
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    for (NSString *key in allKeys) {
        if ([key isEqualToString:@"timespan"] || [key isEqualToString:@"sign"]) {
            continue;
        }
        [mutableString appendString:[params objectForKey:key]];
    }
    return [NSString stringWithFormat:@"%@%@",url,mutableString];
}

- (void)cancelAllTask{
    if (self.session) {
        [self.session.session invalidateAndCancel];
        [self.session.operationQueue cancelAllOperations];
    }
}

@end
