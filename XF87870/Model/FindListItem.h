//
//  FindListItem.h
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//"authorname":"admin",
//"authorphotourl":"http://pic.87870.com/upload/images/vr87870/2016/10/10/th_100x100_aead8ff4-a78c-40b1-9f8e-a46f4694236c.jpg",
//"columnid":"3_1",
//"comment":"0",
//"createdate":"2016/11/8 15:11:27",
//"description":"111",
//"gamegrade":"5",
//"id":"15831",
//"imageurllist":[
//                {
//                    "imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/0640fb50-ea98-4e5d-84f4-1b81054bdecd.jpg"
//                }
//                ],
//"isfavorite":"0",
//"islike":"0",
//"label":"评测",
//"like":"1",
//"name":"第一公会",
//"shareurl":"http://172.16.16.20:5002/share/sharexw.aspx?id=15831",
//"videoinfo":null
@interface FindListItem : NSObject
@property (copy, nonatomic) NSString *AuthorName;
@property (copy, nonatomic) NSString *AuthorPhotoUrl;
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Comment;
@property (copy, nonatomic) NSString *CreateDate;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *GameGrade;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSArray *ImageUrlList;
@property (copy, nonatomic) NSString *IsFavorite;
@property (copy, nonatomic) NSString *IsLike;
@property (copy, nonatomic) NSString *Like;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShareUrl;
@property (copy, nonatomic) NSString *Label;
@property (copy, nonatomic) NSString *VideoImageUrl;
@property (copy, nonatomic) NSString *VideoUrl;
@property (assign, nonatomic) CGFloat cellHeight;

@property (copy, nonatomic) NSString *shareImageUrl;

- (instancetype) initWithJson:(NSDictionary*)json;
@end
