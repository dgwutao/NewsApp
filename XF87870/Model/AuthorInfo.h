//
//  AuthorInfo.h
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorInfo : NSObject
//"authorInfo":{
//    "description":"不是很懂二次元",
//    "id":"90",
//    "name":"",
//    "userphoto":"http://pic.87870.com/upload/images/vr87870/2016/10/18/th_100x100_86c8064b-2e42-4dae-935c-ba8e0bfad0e2.jpg"
//},

@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *UserPhoto;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *Id;

-(instancetype) initWithJson:(NSDictionary*)json;
@end
