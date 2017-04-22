//
//  HardwareCategory.m
//  XF87870
//
//  Created by xf on 2016/11/21.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "HardwarecaItem.h"

@implementation HardwarecaItem

-(instancetype)initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.Cid = [json objectForKey:@"cid"];
        self.Name = [json objectForKey:@"name"];
    }
    return self;
}
@end
