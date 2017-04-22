//
//  BannerItem.h
//  XF87870
//
//  Created by xf on 2016/11/11.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"columnid":"1","id":"","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/4e5d1f0e-142d-497e-bd63-a821b3b0c689.jpg","name":"测试222","type":"1","url":""},{"columnid":"2","id":"2","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/8ab5426a-0185-400a-a312-8677cc7dc6c5.jpg","name":"测试111","type":"2","url":""}]}
@interface BannerItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImageUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *Type;
@property (copy, nonatomic) NSString *Url;

-(instancetype) initWithJson:(NSDictionary*)json;
@end
