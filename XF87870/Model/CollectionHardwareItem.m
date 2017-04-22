//
//  CollectionHardwareItem.m
//  XF87870
//
//  Created by xf on 2016/11/30.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CollectionHardwareItem.h"

@implementation CollectionHardwareItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Img = [json objectForKey:@"img"];
        self.Id = [json objectForKey:@"id"];
        self.ImgUrl = [json objectForKey:@"imgurl"];
        self.Name = [json objectForKey:@"name"];
        self.Url = [json objectForKey:@"url"];
        self.FavId = [json objectForKey:@"favid"];
        self.ShareUrl = [json objectForKey:@"shareurl"];
        self.Description = [json objectForKey:@"description"];
        self.EvaluationId = [json objectForKey:@"evaluationid"];
        self.Price = [json objectForKey:@"price"];
    }
    return self;
}

@end
