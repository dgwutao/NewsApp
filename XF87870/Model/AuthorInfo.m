//
//  AuthorInfo.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "AuthorInfo.h"

@implementation AuthorInfo
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.UserPhoto = [json objectForKey:@"userphoto"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.Description = [json objectForKey:@"description"];
    }
    return self;
}
@end
