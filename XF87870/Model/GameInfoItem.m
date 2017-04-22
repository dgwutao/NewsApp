//
//  GameInfoItem.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "GameInfoItem.h"

@implementation GameInfoItem

- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.ImageUrl = [json objectForKey:@"imageurl"];
        self.BagName = [json objectForKey:@"bagname"];
        self.BagVersions = [json objectForKey:@"bagversions"];
        self.CreateDate = [json objectForKey:@"createdate"];
        self.GameSize = [json objectForKey:@"gamesize"];
        self.GameSource = [json objectForKey:@"gamesource"];
        self.GameType = [json objectForKey:@"gametype"];
        self.Img = [json objectForKey:@"img"];
        self.LoadCondition = [json objectForKey:@"loadcondition"];
        self.MakeFactory = [json objectForKey:@"makefactory"];
        self.ShareUrl = [json objectForKey:@"shareurl"];
        self.XingJi = [json objectForKey:@"xingji"];
    }
    return self;
}

@end
