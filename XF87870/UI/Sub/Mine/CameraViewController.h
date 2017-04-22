//
//  CameraViewController.h
//  XF87870
//
//  Created by xf on 2016/12/6.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import "XFBaseViewController.h"
#import "EditPhotoViewController.h"

@interface CameraViewController : XFBaseViewController<EditPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;

@end
