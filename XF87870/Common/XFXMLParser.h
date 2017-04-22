//
//  XFXMLParser.h
//  XF87870
//
//  Created by xf on 2016/11/24.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFXMLParser : NSObject<NSXMLParserDelegate>
- (instancetype)initWithNSData:(NSData*)data;
- (NSArray*) parse;
@end
