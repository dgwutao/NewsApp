//
//  RecommendItem.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "RecommendItem.h"

@implementation RecommendItem

- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.ImageUrl = [json objectForKey:@"imageurl"];
        self.ShortName = [json objectForKey:@"shortname"];
        self.Tag = [json objectForKey:@"tag"];
    }
    return self;
}

@end
