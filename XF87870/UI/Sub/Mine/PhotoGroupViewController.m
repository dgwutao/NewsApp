//
//  PhotoGroupViewController.m
//  XF87870
//
//  Created by xf on 2016/12/7.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "PhotoGroupViewController.h"
#import "PhotoGroupCollectionViewCell.h"

@interface PhotoGroupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

static NSString *collectionViewCellIdentifier = @"PhotoGroupCollectionViewCellIdentifier";

@implementation PhotoGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray new];
    [super setLeftNavItemWithImage:@"ic_nav_back"];
    [self.view addSubview:self.collectionView];
    @autoreleasepool {
        __weak typeof (self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [weakSelf.assetGroup.group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
                if (asset) {
                    AssetItem *assetItem = [AssetItem new];
                    assetItem.AssetThumbnail = [UIImage imageWithCGImage:[asset thumbnail]];
                    assetItem.AssetImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    [weakSelf.dataSource addObject:assetItem];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.collectionView reloadData];
                    });
                }
            }];
        });
    }
}

- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64.0f) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"PhotoGroupCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionViewCellIdentifier];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.row) {
        AssetItem *asset = [self.dataSource objectAtIndex:indexPath.row];
        PhotoGroupCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
        [cell.photoImageView setImage:asset.AssetThumbnail];
        return cell;
    }
    return [UICollectionViewCell new];
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = SCREEN_WIDTH / 4;
    return (CGSize){width, width};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count > indexPath.row) {
        AssetItem *asset = [self.dataSource objectAtIndex:indexPath.row];
        EditPhotoViewController *controller = [[EditPhotoViewController alloc]initWithNibName:@"EditPhotoViewController" bundle:nil];
        controller.originalImage = asset.AssetImage;
        controller.cropFrame = CGRectMake(0, 100.0f, SCREEN_WIDTH, SCREEN_WIDTH);
        controller.limitRatio = 3.0f;
        controller.delegate = self;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)imageCropper:(UIImage *)editedImage
{
    
}

@end
