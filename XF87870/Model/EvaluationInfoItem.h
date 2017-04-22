//
//  EvaluationInfoItem.h
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationInfoItem : NSObject
//  EvaluationInfo    {"result":{"msg":"SUCCESS","ret":"0"},"version":"1.0","zparam":null,"infolist":[{"columnid":"3_2","id":"15831","img":"0640fb50-ea98-4e5d-84f4-1b81054bdecd.jpg","imgurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/0640fb50-ea98-4e5d-84f4-1b81054bdecd.jpg","name":"第一公会","shareurl":"http://172.16.16.20:5002/share/sharepc.aspx?id=15831"},{"columnid":"3_2","id":"8087","img":"","imgurl":"","name":"乐视VR移动头盔“LeVR COOL 1”初体验","shareurl":"http://172.16.16.20:5002/share/sharepc.aspx?id=8087"}],"number":"2","page":"1"}

@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *Img;
@property (copy, nonatomic) NSString *ImgUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShareUrl;

-(instancetype) initWithJson:(NSDictionary*)json;
@end
