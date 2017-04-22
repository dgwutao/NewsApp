//
//  ParameterInfo.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "ParameterInfo.h"

@implementation ParameterInfo
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.AudioEffect = [json objectForKey:@"audioeffect"];
        self.Impression = [json objectForKey:@"impression"];
        self.Interest = [json objectForKey:@"interest"];
        self.VideoImage = [json objectForKey:@"videoimage"];
        NSArray *platformInfo = [json objectForKey:@"platforminfo"];
        NSMutableArray *platforms = [NSMutableArray arrayWithCapacity:platformInfo.count];
        for (NSDictionary *platform in platformInfo) {
            [platforms addObject:[platform objectForKey:@"name"]];
        }
        self.Platforminfo = platforms;
    }
    return self;
}
@end
