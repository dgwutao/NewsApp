//
//  CommentItem.m
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentItem.h"
//{
//    "":"0",
//    "":"0",
//    "":"喜欢小编的文章",
//    "":"2016/11/4 11:50:51",
//    "":"81102",
//    "":"0",
//    "list":[
//    
//    ],
//    "":"芒果绿了",
//    "":"433757",
//    "":"http://pic.87870.com/upload/images/87870user/2016/9/26/th_150x150_9cee388a-95bd-450e-b97d-6b1b25115d61.jpg"
//}
@implementation CommentItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.Like = [json objectForKey:@"_like"];
        self.Comment = [json objectForKey:@"comment"];
        self.Content = [json objectForKey:@"content"];
        self.CreateDate = [XFUtil getShortDateString:[json objectForKey:@"createdate"]];
        self.Id = [json objectForKey:@"id"];
        self.IsLike = [json objectForKey:@"islike"];
        self.NickName = [json objectForKey:@"nickname"];
        self.Uid = [json objectForKey:@"uid"];
        self.UserPhoto = [json objectForKey:@"userphoto"];
        NSArray *arr = [json objectForKey:@"list"];
        NSMutableArray *comments = [NSMutableArray arrayWithCapacity:arr.count];
        for (NSDictionary *dic in arr) {
            CommentReplyItem *reply = [[CommentReplyItem alloc]initWithJson:dic];
            [comments addObject:reply];
        }
        self.List = comments;
    }
    return self;
}
@end
