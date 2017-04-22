//
//  SubBannerItem.h
//  XF87870
//
//  Created by xf on 2016/11/11.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"columnid":"7_1","id":"070101","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/b7052ba4-e16a-4307-b919-a75e493017bb.jpg","name":"VR挊报","shortname":"VR挊报VR挊报VR挊报"},{"columnid":"7_2","id":"070102","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/7/78a05865-48ce-4ea7-ba1d-a42e25c3908f.jpg","name":"脑后不插管","shortname":""},{"columnid":"7_1","id":"070103","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/21c6be2e-2dd2-4a1d-bd5e-827ebad2c803.jpg","name":"VR喷它秀","shortname":""},{"columnid":"7_2","id":"070104","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/4c625b12-3b01-4d97-b133-502b23581180.jpg","name":"这很VR","shortname":""},{"columnid":"7_2","id":"070105","imageurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/4/cd423247-d72e-4bb6-ab19-b416885e6ff3.jpg","name":"VR狂躁症","shortname":"VR狂躁症VR狂躁症VR狂躁症"}]}
@interface SubBannerItem : NSObject
@property (copy, nonatomic) NSString *ColumnId;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImageUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *ShortName;

-(instancetype) initWithJson:(NSDictionary *)json;
@end
