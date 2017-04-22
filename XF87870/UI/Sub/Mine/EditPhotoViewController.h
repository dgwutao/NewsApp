//
//  EditPhotoViewController.h
//  XF87870
//
//  Created by xf on 2016/12/6.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"
#import "AssetItem.h"
@class WYImageCropperViewController;

@protocol EditPhotoViewDelegate <NSObject>

- (void)imageCropper:(UIImage *)editedImage;

@end

@interface EditPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@property (assign, nonatomic) NSInteger tag;
@property (weak, nonatomic) id<EditPhotoViewDelegate>delegate;
@property (assign, nonatomic) CGRect cropFrame;

@property (strong, nonatomic)UIImage *originalImage;
@property (strong, nonatomic)UIImage *editedImage;

@property (strong, nonatomic)UIImageView *showImgView;
@property (strong, nonatomic)UIView *overlayView;
@property (strong, nonatomic)UIView *ratioView;

@property (assign, nonatomic)CGRect oldFrame;
@property (assign, nonatomic)CGRect largeFrame;
@property (assign, nonatomic)CGFloat limitRatio;

@property (assign, nonatomic)CGRect latestFrame;

@end
