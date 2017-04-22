//
//  AdsScrollView.h
//  Widget
//
//  Created by bita on 17/4/28.
//  Copyright © 2016年 xf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFBannerView : UIView<UIScrollViewDelegate>

@property (copy, nonatomic) void (^bannerTapped)(NSInteger index);

- (void)remove;

+ (XFBannerView*)initBannerViewWithFrame:(CGRect)frame
                            imageLinkURL:(NSArray*)imageLinkURL
                           subtitleArray:(NSArray*)subtitles
                     placeHoderImageName:(NSString*)placeHolder
                            bannerTapped:(void(^)(NSInteger index))tapped;

+ (XFBannerView*)initBannerViewWithFrame:(CGRect)frame
                          localImagePath:(NSArray*)localImagePath
                           subtitleArray:(NSArray*)subtitles
                            bannerTapped:(void(^)(NSInteger index))tapped;

- (void)refreshBannerWithImageUrls:(NSArray*)imageUrls;
@end
