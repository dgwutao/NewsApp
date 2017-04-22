//
//  XFHttpRequest.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "XFHttpResponseParser.h"

@interface XFHttpRequestManger : NSObject
- (void) sendGetHttpRequestWithUrl:(NSString*)url
                            params:(NSDictionary*) parameters
                            parser:(responseParser)parser
                          progress:(void(^)(NSProgress *progressValue)) progress
                           success:(void (^)(id response)) success
                           failure:(void(^)(NSError *error)) failure;

- (void) sendPostHttpRequestWithUrl:(NSString*)url
                             params:(NSDictionary*) parameters
                          bodyBlock:(void (^)(id <AFMultipartFormData> formData))dataBlock
                           progress:(void(^)(NSProgress *progressValue)) progress
                            success:(void (^)(NSDictionary *response)) success
                            failure:(void(^)(NSError *error)) failure;

- (void) cancelAllTask;
@end
