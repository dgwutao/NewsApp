//
//  BannerItem.m
//  XF87870
//
//  Created by xf on 2016/11/11.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BannerItem.h"

@implementation BannerItem

-(instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.ImageUrl = [json objectForKey:@"imageurl"];
        self.Name = [json objectForKey:@"name"];
        self.Type = [json objectForKey:@"type"];
        self.Url = [json objectForKey:@"url"];
        self.Id = [json objectForKey:@"id"];
    }
    return self;
}
@end
