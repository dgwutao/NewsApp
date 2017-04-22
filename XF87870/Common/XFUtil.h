//
//  XFUtil.h
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFUtil : NSObject
+ (NSString*) getTimestamp;
+ (NSString*) getIPAddress;
+ (NSString*) getHexWithNSData:(NSData *)data useLower:(BOOL)isOutputLower;
+ (NSString*) getMD5WithNSString:(NSString*)source;
+ (NSString*) getHmacMD5WithNSString:(NSString*) str andKey:(NSString*) key;
+ (NSString*) getDateStringWithTimestamp:(NSString*)timestamp formate:(NSString*)formate;
+ (NSString*) getCidWithColumnId:(NSString*)columnid;
+ (UIImage*) getShareThumbnail:(NSString*)imageUrl;
+ (NSData*) compressUIImageWithMaxBytes:(NSUInteger)bytes image:(UIImage*)image;
+ (NSString*) getShortDateString:(NSString*)dateString;
void showOrHideErrorView(BOOL showOrHide,UIView *parentView,NSString *image,NSString *tip);
@end
