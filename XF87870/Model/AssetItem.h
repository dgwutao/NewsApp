//
//  AssetItem.h
//  XF87870
//
//  Created by xf on 2016/12/7.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetItem : NSObject

@property (nonatomic, copy) NSString *AssetPath;

@property (nonatomic, strong) UIImage *AssetThumbnail;

@property (nonatomic, strong) UIImage *AssetImage;

@property (nonatomic, copy) NSString *AssetDate;

@property (nonatomic, copy) NSString *AssetLocation;

@property (nonatomic, assign) CGSize AssetDimension;

@end
