//
//  HardwareInfoItem.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "HardwareInfoItem.h"

@implementation HardwareInfoItem

- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.Img = [json objectForKey:@"img"];
        self.ImgUrl = [json objectForKey:@"imgurl"];
        self.ShareUrl = [json objectForKey:@"shareurl"];
        self.Comment = [json objectForKey:@"comment"];
        self.Description = [json objectForKey:@"description"];
        self.EvaluationId = [json objectForKey:@"evaluationid"];
        self.IsLike = [json objectForKey:@"islike"];
        self.Price = [json objectForKey:@"price"];
        self.Url = [json objectForKey:@"url"];
    }
    return self;
}
@end
