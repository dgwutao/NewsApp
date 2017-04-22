//
//  CommentReplyItem.m
//  XF87870
//
//  Created by xf on 2016/12/12.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentReplyItem.h"

@implementation CommentReplyItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.Like = [json objectForKey:@"_like"];
        self.Content = [json objectForKey:@"content"];
        self.Id = [json objectForKey:@"id"];
        self.IsLike = [json objectForKey:@"islike"];
        self.NickName = [json objectForKey:@"nickname"];
        self.Uid = [json objectForKey:@"uid"];
    }
    return self;
}
@end
