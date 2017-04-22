//
//  FeedDetailItem.m
//  XF87870
//
//  Created by xf on 2016/11/22.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "FeedDetailItem.h"
#import "RecommendItem.h"

@implementation FeedDetailItem
- (instancetype) initWithJson:(NSDictionary *)json
{
    if (self = [super init]) {
        self.From = [json objectForKey:@"_from"];
        self.Like = [json objectForKey:@"_like"];
        self.Author = [json objectForKey:@"author"];
        self.AppInfoImage = [json objectForKey:@"appinfoimage"];
        self.GameGrade = [json objectForKey:@"gamegrade"];
        NSDictionary *dic = [json objectForKey:@"authorinfo"];
        AuthorInfo *authorInfo = [[AuthorInfo alloc]initWithJson:dic];
        self.AuthorInfo = authorInfo;
        self.ColumnId = [json objectForKey:@"columnid"];
        self.Comment = [json objectForKey:@"comment"];
        NSString *base64Str = [json objectForKey:@"content"];
        if (base64Str && base64Str.length > 0) {
            NSData *base64Data = [[NSData alloc]initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
            self.Content = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
        }else{
            self.Content = @"";
        }
        self.CreateDate = [json objectForKey:@"createdate"];
        self.IsFavorite = [json objectForKey:@"isfavorite"];
        self.Id = [json objectForKey:@"id"];
        self.IsFavoriteAdmin = [json objectForKey:@"isfavoriteadmin"];
        self.Description = [json objectForKey:@"description"];
        self.IsLike = [json objectForKey:@"islike"];
        self.PlayerImage = [json objectForKey:@"playerimage"];
        self.PlayerUrl = [json objectForKey:@"playerurl"];
        self.ShareUrl = [json objectForKey:@"shareurl"];
        NSArray *recommends = [json objectForKey:@"recommentList"];
        NSMutableArray *recommendList = [NSMutableArray arrayWithCapacity:recommends.count];
        for (NSDictionary *recommend in recommends) {
            RecommendItem *item = [[RecommendItem alloc]initWithJson:recommend];
            [recommendList addObject:item];
        }
        self.RecommendList = recommendList;
        self.Name = [json objectForKey:@"name"];
        
        NSDictionary *gameInfo = [json objectForKey:@"gameinfo"];
        if (gameInfo) {
            self.GameInfo = [[GameInfoItem alloc]initWithJson:gameInfo];
        }
        
        NSDictionary *parameterInfo = [json objectForKey:@"parameterinfo"];
        if (parameterInfo) {
            self.ParameterInfo = [[ParameterInfo alloc]initWithJson:parameterInfo];
        }
    }
    return self;
}

@end
