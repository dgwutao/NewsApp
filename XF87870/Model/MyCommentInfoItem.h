//
//  MyCommentInfoItem.h
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentInfoItem.h"

//"content":"哈哈哈哈哈",
//"createdate":"2016/12/1 11:23:00",
//"id":"81331",
//"info":{
//    "columnid":"1_0",
//    "id":"15830",
//    "img":"d7867b64-4173-437e-94a7-0444806a959e.jpg",
//    "imgurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/",
//    "name":"大半夜走楼梯多恐怖？ 《黑暗楼梯》让你走个够"
//},
//"nickname":"87870用户",
//"uid":"123123",
//"userphoto":"http://www.87870.com/images/noface.jpg"
@interface MyCommentInfoItem : NSObject
@property (copy, nonatomic) NSString *Content;
@property (copy, nonatomic) NSString *CreateDate;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *NickName;
@property (copy, nonatomic) NSString *Uid;
@property (copy, nonatomic) NSString *UserPhoto;
@property (strong, nonatomic) CommentInfoItem *info;

@property (assign, nonatomic) CGFloat cellHeight;
- (instancetype) initWithJson:(NSDictionary *)json;

@end
