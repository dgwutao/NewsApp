//
//  NSString+Extension.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(SIZE)

-(CGSize) sizeWithAttributes:(CGSize)maxSize Attributes:(NSDictionary *)attributes{
    CGSize s;
    CGRect frame = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    s.width = frame.size.width;
    s.height = frame.size.height;
    return s;
}
@end

@implementation NSString (Authentication)
- (BOOL)isRightIDCardNumberWithString {
    if (self.length==15 || self.length==18) {
        for (int i=0; i<self.length-1; i++) {
            NSString *number = [self substringWithRange:NSMakeRange(i, 1)];
            if (![number isEqualToString:@"0"] && !([number intValue] <=9 && [number intValue]>0)) {
                return NO;
            }
        }
        NSString *last_number = [self substringWithRange:NSMakeRange(self.length-1, 1)];
        if (![last_number isEqualToString:@"0"] && ![last_number isEqualToString:@"x"] && ![last_number isEqualToString:@"X"] && !([last_number intValue] <=9 && [last_number intValue]>0)) {
            return NO;
        }
        
        if (self.length==15 && ([last_number isEqualToString:@"X"] || [last_number isEqualToString:@"x"])) {
            return NO;
        }
    } else {
        return NO;
    }
    return YES;
}

- (BOOL)isRightChineseName {
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isRightCode {
    NSString *regex = @"\\d+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self] && self.length==6) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isAllNumber{
    NSString *regex = @"\\d+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isPhoneNumber {
    NSString *regex = @"\\d+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self] && self.length == 11 && [self substringWithRange:NSMakeRange(0, 1)].intValue == 1) {
        return YES;
    } else {
        return NO;
    }
}
@end
