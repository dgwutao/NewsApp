//
//  MyCommentInfoItem.m
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "MyCommentInfoItem.h"

@implementation MyCommentInfoItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.Content = [json objectForKey:@"content"];
        self.CreateDate = [XFUtil getShortDateString:[json objectForKey:@"createdate"]];
        self.Id = [json objectForKey:@"id"];
        self.NickName = [json objectForKey:@"nickname"];
        self.Uid = [json objectForKey:@"uid"];
        self.UserPhoto = [json objectForKey:@"userphoto"];
        NSDictionary *info = [json objectForKey:@"info"];
        self.info = [[CommentInfoItem alloc]initWithJson:info];
    }
    return self;
}
@end
