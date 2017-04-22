//
//  SubBannerItem.m
//  XF87870
//
//  Created by xf on 2016/11/11.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "SubBannerItem.h"

@implementation SubBannerItem
-(instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.ImageUrl = [json objectForKey:@"imageurl"];
        self.Name = [json objectForKey:@"name"];
        self.ShortName = [json objectForKey:@"shortname"];
        self.Id = [json objectForKey:@"id"];
    }
    return self;
}
@end
