//
//  ShareView.h
//  XF87870
//
//  Created by xf on 2016/11/14.
//  Copyright © 2016年 HappyNetwork. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShareToSocialOptions) {
    XFWeChatFriend = 1 << 0,
    XFWeChatMoments = 1 << 1,
    XFWeibo = 1 << 2,
    XFQQ = 1 << 3,
    XFQZone = 1 << 4,
    XFCollect = 1 << 5,
    XFLike = 1 << 6,
    XFCopyUrl = 1 << 7
};

@interface ShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@property (copy, nonatomic) NSString *infoId;
@property (copy, nonatomic) NSString *cid;
@property (copy, nonatomic) NSString *feedName;
@property (copy, nonatomic) NSString *feedDescription;
@property (copy, nonatomic) NSString *webPageUrl;
@property (strong, nonatomic) NSString *shareImageUrl;

- (void) showWithOptions:(ShareToSocialOptions)options;
@end
