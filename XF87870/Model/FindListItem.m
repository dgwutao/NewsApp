//
//  FindListItem.m
//  XF87870
//
//  Created by xf on 2016/11/10.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FindListItem.h"

@implementation FindListItem

-(instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.AuthorName = [json objectForKey:@"authorname"];
        self.AuthorPhotoUrl = [json objectForKey:@"authorphotourl"];
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Comment = [json objectForKey:@"comment"];
        self.CreateDate = [XFUtil getShortDateString:[json objectForKey:@"createdate"]];
        self.Description = [json objectForKey:@"description"];
        self.GameGrade = [json objectForKey:@"gamegrade"];
        self.Id = [json objectForKey:@"id"];
        self.IsFavorite = [json objectForKey:@"isfavorite"];
        NSArray *imageList = [json objectForKey:@"imageurllist"];
        NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:imageList.count];
        for (NSDictionary *dic in imageList) {
            [imageArray addObject:[dic objectForKey:@"imageurl"]];
        }
        self.ImageUrlList = imageArray;
        self.IsLike = [json objectForKey:@"islike"];
        self.Label = [json objectForKey:@"label"];
        self.Like = [json objectForKey:@"like"];
        self.ShareUrl = [json objectForKey:@"shareurl"];
        if ([self.Label isEqualToString:@"视频"]) {
            NSDictionary *videoDic = [json objectForKey:@"videoinfo"];
            self.VideoUrl = [videoDic objectForKey:@"url"];
            self.VideoImageUrl = [videoDic objectForKey:@"imageurl"];
        }
        self.Name = [json objectForKey:@"name"];
    }
    return self;
}
@end
