//
//  XFUtil.m
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFUtil.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation XFUtil

static NSNumberFormatter *numberFormatter;
static NSDateFormatter *dateFormatter;

+ (NSString*) getTimestamp
{
    return [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
}

+ (NSString*) getDateStringWithTimestamp:(NSString*)timestamp formate:(NSString*)formate
{
    if (!numberFormatter) {
        numberFormatter = [[NSNumberFormatter alloc]init];
    }
    numberFormatter.numberStyle = NSNumberFormatterNoStyle;
    NSNumber *number = [numberFormatter numberFromString:timestamp];
    if (number) {
        long timeStamp = [number longValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc]init];
        }
        NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
        [dateFormatter setTimeZone:timeZone];
        [dateFormatter setDateFormat:formate];
        return [dateFormatter stringFromDate:date];
    } else {
        return @"";
    }
}

+ (NSString*) getShortDateString:(NSString*)dateString
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc]init];
    }
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *currentDate = [NSDate date];
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSString *string;
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:date];
    NSInteger seconds = interval;
    NSInteger minutes = seconds / 60;
    NSInteger hours = minutes / 60;
    if (minutes < 10) {
        string = [NSString stringWithFormat:@"%@",@"刚刚"];
    }else if (hours < 1 && minutes > 10) {
        string = [NSString stringWithFormat:@"%zi分钟前",minutes];
    }else if (hours >= 1 && hours < 24) {
        string = [NSString stringWithFormat:@"%zi小时前",hours];
    }else if (hours >= 24 && hours < 10 * 24) {
        string = [NSString stringWithFormat:@"%zi天前",hours / 24];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        string = [dateFormatter stringFromDate:date];
    }
    return string;
}

+ (NSString*) getHmacMD5WithNSString:(NSString*) str andKey:(NSString*) key{
    unsigned char *digest;
    digest = malloc(CC_MD5_DIGEST_LENGTH);
    NSData *hashData = [str dataUsingEncoding:NSUTF8StringEncoding];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgMD5, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    NSData *cipherData = [NSData dataWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    NSString *md5 = [[NSString alloc]initWithData:cipherData encoding:NSUTF8StringEncoding];
    free(digest);
    return md5;
}

+ (NSString*) getMD5WithNSString:(NSString*)source
{
    const char *cStr = [source UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString *md5 = [NSString stringWithFormat:
                      @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    return md5;
}

+ (NSString*) getHexWithNSData:(NSData *)data useLower:(BOOL)isOutputLower
{
    if (data.length == 0) { return nil; }
    static const char HexEncodeCharsLower[] = "0123456789abcdef";
    static const char HexEncodeChars[] = "0123456789ABCDEF";
    char *resultData;
    resultData = malloc([data length] * 2 +1);
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    NSUInteger length = [data length];
    if (isOutputLower) {
        for (NSUInteger index = 0; index < length; index++) {
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (NSUInteger index = 0; index < length; index++) {
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    return result;
}

+ (NSString*) getIPAddress
{
    NSArray *searchArray = @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    DebugLog(@"addresses: %@", addresses);
    
    NSString *address;
    for (NSString *key in searchArray) {
        address = addresses[key];
        if([self isValidatIP:address]) {
            break;
        }
    }
    return address ? address : @"0.0.0.0";
}

+ (BOOL) isValidatIP:(NSString *)ipAddress {
    if (!ipAddress || ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            DebugLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *) getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString*) getCidWithColumnId:(NSString*)columnid
{
    if ([columnid rangeOfString:@"_"].location != NSNotFound) {
        NSArray *array = [columnid componentsSeparatedByString:@"_"];
        if (array.count > 0) {
            return array.firstObject;
        }
    }
    return columnid;
}

void showOrHideErrorView(BOOL showOrHide,UIView *parentView,NSString *image,NSString *tip) {
    UIView *view = [parentView viewWithTag:100010];
    if (!showOrHide) {
        if (view) {
            view.alpha = 0;
            if (view.superview) {
                [view.superview sendSubviewToBack:view];
                [view removeFromSuperview];
            }
        }
    }else {
        if (view == nil) {
            view = [[UIView alloc] initWithFrame:CGRectZero];
            view.tag = 100010;
            view.alpha = 0;
            view.backgroundColor = [UIColor colorWithHexValue:0xF2F2F2 alpha:1.0f];
            UIImageView *imgView;
            if (image && image.length > 0) {
                view.frame = CGRectMake(0, 0, parentView.bounds.size.width, parentView.bounds.size.height);
                imgView = [[UIImageView alloc] initWithFrame:CGRectMake((view.bounds.size.width - 110.0f) / 2, 133.0f, 110.0f, 110.0f)];
                imgView.image = [UIImage imageNamed:image];
                [view addSubview:imgView];
            }else{
                view.frame = CGRectMake(0, 0, parentView.bounds.size.width, parentView.bounds.size.height);
            }
            
            if (tip && tip.length > 0) {
                UILabel * lbTips = [[UILabel alloc] init];
                lbTips.font = [UIFont systemFontOfSize:14];
                lbTips.textAlignment = NSTextAlignmentCenter;
                lbTips.numberOfLines = 1;
                lbTips.textColor = [UIColor colorWithHexValue:0xBABABA alpha:1.0f];
                if (imgView) {
                    lbTips.frame = CGRectMake(0, imgView.frame.size.height + 10.0f,view.frame.size.width, 20.0f);
                }else{
                    lbTips.frame = CGRectMake(0, (view.bounds.size.height - 20.0f) / 2,view.frame.size.width, 20.0f);
                }
                lbTips.text = tip;
                [view addSubview:lbTips];
            }
            
            [parentView addSubview:view];
        }
        view.alpha = 1;
        [parentView bringSubviewToFront:view];
    }
}

+ (UIImage*) getShareThumbnail:(NSString*)imageUrl
{
    if (imageUrl && imageUrl.length > 0) {
        NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:imageUrl]];
        return [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    }
    return [UIImage imageNamed:@"ic_user_about"];
}

+ (NSData *)compressUIImageWithMaxBytes:(NSUInteger)bytes image:(UIImage*)image
{
    CGFloat ratio = 1.0f;
    NSData *compressed = UIImageJPEGRepresentation(image, ratio);
    NSUInteger curBytes = compressed.length;
    ratio = (CGFloat)bytes / curBytes;
    
    while (true) {
        if (curBytes <= bytes) {
            return compressed;
        }
        if (ratio <= 0) {
            compressed = UIImageJPEGRepresentation(image, 0.0);
            curBytes = [compressed length];
            if (curBytes <= bytes) {
                return compressed;
            }
            else {
                return nil;
            }
        }
        else {
            compressed = UIImageJPEGRepresentation(image, ratio);
            curBytes = compressed.length;
            ratio -= 0.05;
        }
    }
    return nil;
}

@end
