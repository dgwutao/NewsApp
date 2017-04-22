//
//  AssetGoupItem.h
//  XF87870
//
//  Created by xf on 2016/12/6.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetGoupItem : NSObject

@property (nonatomic, copy) NSString *groupName;

@property (nonatomic, strong) UIImage *thumbImage;

@property (nonatomic, assign) NSInteger assetsCount;

@property (nonatomic, copy) NSString *type;

@property (strong, nonatomic) ALAssetsGroup *group;

@end
