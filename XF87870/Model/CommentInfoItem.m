//
//  CommentInfoItem.m
//  XF87870
//
//  Created by xf on 2016/12/1.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "CommentInfoItem.h"

@implementation CommentInfoItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Name = [json objectForKey:@"name"];
        self.Id = [json objectForKey:@"id"];
        self.Img = [json objectForKey:@"img"];
        self.ImgUrl = [json objectForKey:@"imgurl"];
    }
    return self;
}
@end
