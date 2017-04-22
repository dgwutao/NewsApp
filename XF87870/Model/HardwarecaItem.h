//
//  HardwareCategory.h
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HardwarecaItem : NSObject
//  hardwarecainfo    {"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"cid":"1000001","name":"VR盒子"},{"cid":"1000002","name":"VR一体机"},{"cid":"1000003","name":"VR头盔"}]}
@property (copy, nonatomic) NSString *Cid;
@property (copy, nonatomic) NSString *Name;

-(instancetype) initWithJson:(NSDictionary*)json;
@end
