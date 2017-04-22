//
//  BoutiqueInfoItem.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "BoutiqueInfoItem.h"
//{"result":{"msg":"SUCCESS","ret":"0"},"version":"2.0","zparam":null,"infolist":[{"columnid":"7_1","createdate":"2016-11-02","description":"我感觉以后择偶标准都不是什么滴滴司机了，下回女方就直接问：“你是不是VR玩家啊？”","id":"15743","img":"b7052ba4-e16a-4307-b919-a75e493017bb.jpg","imgurl":"http://172.16.16.20:82/upload/images/vr87870/2016/11/8/","name":"想玩VR游戏？你首先得有套房"},{"columnid":"7_1","createdate":"2016-10-26","description":"现在我们忽视“风口”“颠覆”“革新”“洗牌”等字眼，只站在一个玩家的角度给大家说说 PSVR到底有哪些值得我们购买的亮点？","id":"15506","img":"","imgurl":"","name":"我为什么不想买PSVR？"},{"columnid":"7_1","createdate":"2016-10-19","description":"距离PSVR发售已经将近一周，负面与正面的报道接踵而至。即使面对着致命缺陷的悲报，狂热 的玩家们也没有停止自己的脚步。在现今被称为“VR寒冬”的时期，PSVR能否成为第一艘破冰船呢？","id":"15306","img":"","imgurl":"","name":"PSVR能否成为VR窘境的破冰船？"},{"columnid":"7_1","createdate":"2016-10-12","description":"2016年是VR、AR行业的飞速发展，各大厂商重新布局自己的产业，投入更多的资本布局VR和AR产业让自己跟上时代的步伐。VR和AR在未来的数年内会彻底改变我们的生活。VR元年的下半年，各行业的巨头已经开始布局自己的VR\/AR产业。","id":"14958","img":"","imgurl":"","name":"VR元年的下半年 他们做出了决定！"}],"number":4,"page":1}


@implementation BoutiqueInfoItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.Img = [json objectForKey:@"img"];
        self.ImgUrl = [json objectForKey:@"imgurl"];
        self.Description = [json objectForKey:@"description"];
        self.CreateDate = [json objectForKey:@"createdate"];
    }
    return self;
}
@end
