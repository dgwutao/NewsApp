//
//  XFHttpErrorHandler.m
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFHttpErrorHandler.h"

@implementation XFHttpErrorHandler

+ (void)handleError:(NSError *)error
{
    [XFHttpErrorHandler handleError:error completion:nil];
}

//0	SUCCESS
//-999	程序异常
//-10000	缺少参数
//-10001	参数格式不正确
//-20000	Appid无效
//-20001	Sign校验失败
//-30001	没有数据
//-40001	添加失败
//-40002	删除失败
//-40003	已添加


+ (void)handleError:(NSError *)error completion:(void (^)(NSDictionary *userInfo)) block
{
    NSString *description;
    if (error.code == -999 ) {
        description = @"程序异常";
    }else if (error.code == -10000){
       description = @"缺少参数";
    }else if (error.code == -10001){
        description = @"参数格式不正确";
    }else if (error.code == -20000){
        description = @"Appid无效";
    }else if (error.code == -20001){
        description = @"Sign校验失败";
    }else if (error.code == -30001){
        description = @"没有数据";
    }else if (error.code == -40001){
        description = @"添加失败";
    }else if (error.code == -40002){
        description = @"删除失败";
    }else if (error.code == -40003){
        description = @"已添加";
    }else{
        if (block) {
            block(nil);
        }
    }
#ifdef DEBUG
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:description message:error.domain delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
#endif
}


@end
