//
//  KRVideoPlayerBrightnessView.m
//  KRVideoPlayer
//
//  Created by axel on 17/4/21.
//  Copyright © 2016年 axel. All rights reserved.
//

#import "KRVideoPlayerVolumeView.h"
#import "KRVideoPlayerControlView.h"

static const CGFloat kViewSpacing = 21.0;
static const CGFloat kVolumeIndicatorAutoFadeOutTimeInterval = 1.0;

@interface KRVideoPlayerVolumeView ()

@property (nonatomic, strong, readwrite) NSMutableArray *blocksArray;
@property (nonatomic, strong, readwrite) UIImageView    *volumeImageView;

@end

@implementation KRVideoPlayerVolumeView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [self createVolumeIndicator];
        [self configVolumeNotification];
    }
    return self;
}

- (void)createVolumeIndicator
{
    _volumeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((kVideoVolumeIndicatorViewSide - 50) / 2, kViewSpacing, 50, 50)];
    [_volumeImageView setImage:[UIImage imageNamed:@"kr-video-player-volume"]];
    [self addSubview:_volumeImageView];
    
    self.blocksArray = [NSMutableArray arrayWithCapacity:16];
    
    UIView *blockBackgroundView = [[UIView alloc] initWithFrame:CGRectMake((kVideoVolumeIndicatorViewSide - 105) / 2, 50 + kViewSpacing * 2, 105, 2.75 + 2)];
    blockBackgroundView.backgroundColor = [UIColor colorWithRed:0.25f green:0.22f blue:0.21f alpha:0.65];
    [self addSubview:blockBackgroundView];
    
    CGFloat margin = 1;
    CGFloat blockW = 5.5;
    CGFloat blockH = 2.75;
    
    for (NSInteger i = 0; i < 16; i++) {
        CGFloat locX = i * (blockW + margin) + margin;
        UIImageView *blockView = [[UIImageView alloc] init];
        blockView.backgroundColor = [UIColor whiteColor];
        blockView.frame = CGRectMake(locX, margin, blockW, blockH);
        
        [blockBackgroundView addSubview:blockView];
        [self.blocksArray addObject:blockView];
    }
}

- (void)configVolumeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(volumeChanged:)
                                                 name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                               object:nil];
}

- (void)volumeChanged:(NSNotification *)notification
{
    CGFloat outputVolume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    [self updateVolumeIndicator:outputVolume];
}

- (void)updateVolumeIndicator:(CGFloat)value
{
    self.hidden = NO;
    
    if (self.superview.accessibilityIdentifier) {
        KRVideoPlayerControlView *playerView = (KRVideoPlayerControlView *)self.superview;
        playerView.timeIndicatorView.hidden = YES;
        playerView.brightnessIndicatorView.hidden = YES;
    } else {
        self.superview.accessibilityIdentifier = @"";
    }
    
    CGFloat stage = 1 / 16.0;
    NSInteger level = value / stage;
    
    for (NSInteger i=0; i<self.blocksArray.count; i++) {
        UIImageView *img = self.blocksArray[i];
        
        if (i < level) {
            img.hidden = NO;
        } else {
            img.hidden = YES;
        }
    }
    
    if (value == 0.0) {
        if (!self.volumeImageView.accessibilityIdentifier) {
            self.volumeImageView.accessibilityIdentifier = @"";
            self.volumeImageView.image = [UIImage imageNamed:@"kr-video-player-volumeMute"];
        }
    } else {
        if (self.volumeImageView.accessibilityIdentifier) {
            self.volumeImageView.accessibilityIdentifier = nil;
            self.volumeImageView.image = [UIImage imageNamed:@"kr-video-player-volume"];
        }
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kVolumeIndicatorAutoFadeOutTimeInterval];
}

- (void)animateHide
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.alpha = 1;
        self.superview.accessibilityIdentifier = nil;
    }];
}

@end
