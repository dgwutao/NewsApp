//
//  SubscriptionItem.m
//  XF87870
//
//  Created by xf on 2016/11/29.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionItem.h"

@implementation SubscriptionItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.AdminId = [json objectForKey:@"adminid"];
        self.Description = [json objectForKey:@"description"];
        self.Id = [json objectForKey:@"id"];
        self.ImageUrl = [json objectForKey:@"imageurl"];
        self.Name = [json objectForKey:@"name"];
        self.FavoriteNumber = [json objectForKey:@"favoritenumber"];
        self.InfoNumber = [json objectForKey:@"infonumber"];
    }
    return self;
}
@end
