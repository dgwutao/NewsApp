//
//  CommentReplyItem.h
//  XF87870
//
//  Created by xf on 2016/12/12.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentReplyItem : NSObject
@property (copy, nonatomic) NSString *Like;
@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *IsLike;
@property (copy, nonatomic) NSString *NickName;
@property (copy, nonatomic) NSString *Uid;

@property (assign, nonatomic) CGFloat cellHeight;
- (instancetype) initWithJson:(NSDictionary *)json;

@end
