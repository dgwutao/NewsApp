//
//  SubscriptionItem.h
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
//{"adminid":"91","description":"","favoritenumber":"1","id":"173","imageurl":"http://pic.87870.com/upload/images/vr87870/2016/10/17/th_100x100_9cfe0527-a047-42f0-84c3-dd39840763fd.jpg","infonumber":"21","name":"wangjin"}
@interface SubscriptionItem : NSObject
@property (copy, nonatomic) NSString *AdminId;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *Id;
@property (copy, nonatomic) NSString *ImageUrl;
@property (copy, nonatomic) NSString *Name;
@property (copy, nonatomic) NSString *FavoriteNumber;
@property (copy, nonatomic) NSString *InfoNumber;

- (instancetype) initWithJson:(NSDictionary *)json;
@end
