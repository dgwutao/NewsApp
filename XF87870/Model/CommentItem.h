//
//  CommentItem.h
//  XF87870
//
//  Created by xf on 2016/11/23.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentReplyItem.h"
//{
//    "_like":"0",
//    "comment":"0",
//    "content":"喜欢小编的文章",
//    "createdate":"2016/11/4 11:50:51",
//    "id":"81102",
//    "islike":"0",
//    "list":[
//
//    ],
//    "nickname":"芒果绿了",
//    "uid":"433757",
//    "userphoto":"http://pic.87870.com/upload/images/87870user/2016/9/26/th_150x150_9cee388a-95bd-450e-b97d-6b1b25115d61.jpg"
//}

//"_like": "0",
//"content": "蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林蓝柏林",
//"id": "109619",
//"islike": "0",
//"nickname": "87870用户",
//"uid": "123123"

@interface CommentItem : CommentReplyItem
@property (copy, nonatomic) NSString *Comment;
@property (copy, nonatomic) NSString *CreateDate;
@property (copy, nonatomic) NSString *UserPhoto;
@property (copy, nonatomic) NSArray *List;

@end
