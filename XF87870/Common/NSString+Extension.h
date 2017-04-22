//
//  NSString+Extension.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SIZE)
-(CGSize) sizeWithAttributes:(CGSize)maxSize Attributes:(NSDictionary *)attributes;
@end

@interface NSString (Authentication)
- (BOOL)isRightIDCardNumberWithString;
- (BOOL)isRightChineseName;
- (BOOL)isRightCode;
- (BOOL)isAllNumber;
- (BOOL)isPhoneNumber;
@end
