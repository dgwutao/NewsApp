//
//  PhotoGroupViewController.h
//  XF87870
//
//  Created by xf on 2016/12/7.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"
#import "AssetGoupItem.h"
#import "AssetItem.h"
#import "EditPhotoViewController.h"

@interface PhotoGroupViewController : XFBaseViewController<EditPhotoViewDelegate>
@property (weak, nonatomic) AssetGoupItem *assetGroup;

@end
