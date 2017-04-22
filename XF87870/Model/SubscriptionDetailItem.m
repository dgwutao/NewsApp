//
//  SubscriptionDetailItem.m
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubscriptionDetailItem.h"

@implementation SubscriptionDetailItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Img = [json objectForKey:@"img"];
        self.Id = [json objectForKey:@"id"];
        self.ImgUrl = [json objectForKey:@"imgurl"];
        self.Name = [json objectForKey:@"name"];
        self.ShortName = [json objectForKey:@"shortname"];
        self.Tag = [json objectForKey:@"tag"];
    }
    return self;
}

@end
