//
//  XFLoginKit.m
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFLoginKit.h"

@interface XFLoginKit()
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation XFLoginKit

static XFLoginKit *_instance;

+ (instancetype)sharedLoginKit {
    XFLoginKit *instance = [[self alloc] init];
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:zone] init];
    });
    return _instance;
}

- (BOOL) isLogined
{
    return YES;
}

- (void) loginWithUserName:(NSString *)userName andPassword:(NSString *)password success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.208/ViewStatus.aspx?userName=%@&password=%@",@"KenshinCui",@"123"];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    request.HTTPMethod = @"GET";
//  request.HTTPBody = [@"username=daka&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
           
        }else{
            
        }
    }];
    [dataTask resume];
}

- (void) logout:(void (^)())success failure:(void (^)(NSError *))failure
{
    
}

- (BOOL)isPhoneNumber:(NSString*)phone {
    NSString *regex = @"\\d+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (phone.length == 11 && [pred evaluateWithObject:phone] && [phone substringWithRange:NSMakeRange(0, 1)].intValue == 1) {
        return YES;
    } else {
        return NO;
    }
}

- (NSURLSession*) session
{
    if (!_session) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30.0f;
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return _session;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)dealloc {
    if (_session) {
        [_session invalidateAndCancel];
        _session = nil;
    }
}

@end
