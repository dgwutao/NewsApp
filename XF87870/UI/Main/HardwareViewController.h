//
//  HardwareViewController.h
//  XF87870
//
//  Created by xf on 2016/11/8.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseTableViewController.h"

@interface HardwareViewController : XFBaseTableViewController<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic,strong) UICollectionView *collectionView;


@end
