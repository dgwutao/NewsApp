//
//  XFHttpResponseParser.h
//  XF87870
//
//  Created by xf on 2016/11/9.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFHttpResponseParser : NSObject
typedef id (^responseParser) (NSDictionary *json);

+ (instancetype)sharedParser;

@property (copy, nonatomic) responseParser FindInfoParser;
@property (copy, nonatomic) responseParser ImageSwitchInfoParser;
@property (copy, nonatomic) responseParser SubBannerParser;
@property (copy, nonatomic) responseParser HardwarecaInfoParser;
@property (copy, nonatomic) responseParser EvaluationInfoParser;
@property (copy, nonatomic) responseParser HardwareInfoParser;
@property (copy, nonatomic) responseParser BoutiqueInfoParser;
@property (copy, nonatomic) responseParser BoutiqueInfoDetailParser;
@property (copy, nonatomic) responseParser FeedInfoDetailParser;
@property (copy, nonatomic) responseParser CommentInfoParser;
@property (copy, nonatomic) responseParser UserActionParser;
@property (copy, nonatomic) responseParser SubscriptionParser;
@property (copy, nonatomic) responseParser SubscriptionDetailParser;
@property (copy, nonatomic) responseParser CollectionInfoParser;
@property (copy, nonatomic) responseParser CollectionHardwareParser;
@property (copy, nonatomic) responseParser MyCommentParser;
@end
