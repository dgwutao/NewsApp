//
//  ParameterInfo.h
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParameterInfo : NSObject
//"parameterinfo":{
//    "audioeffect":"3",
//    "impression":"3",
//    "interest":"5",
//    "platforminfo":[
//                    {
//                        "name":"HTC"
//                    }
//                    ],
//    "videoimage":"4"
//},
@property (copy, nonatomic) NSString *AudioEffect;
@property (copy, nonatomic) NSString *Impression;
@property (copy, nonatomic) NSString *Interest;
@property (copy, nonatomic) NSArray *Platforminfo;
@property (copy, nonatomic) NSString *VideoImage;
- (instancetype) initWithJson:(NSDictionary *)json;
@end
