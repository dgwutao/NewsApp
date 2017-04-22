//
//  CommentInfoItem.h
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentInfoItem : NSObject
//"info":{
//    "columnid":"1_0",
//    "id":"15830",
//    "img":"d7867b64-4173-437e-94a7-0444806a959e.jpg",
//    "imgurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/",
//    "name":"大半夜走楼梯多恐怖？ 《黑暗楼梯》让你走个够"
//},
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;

- (instancetype) initWithJson:(NSDictionary *)json;
@end
