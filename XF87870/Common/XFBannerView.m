//
//  AdsScrollView.m
//  Widget
//
//  Created by bita on 17/4/28.
//  Copyright © 2016年 xf. All rights reserved.
//

#import "XFBannerView.h"
#import "UIImageView+WebCache.h"

#define kAdViewWidth  _bannerScrollView.bounds.size.width
#define kAdViewHeight  _bannerScrollView.bounds.size.height
#define HIGHT _bannerScrollView.bounds.origin.y

@interface XFBannerView ()
{
    CGFloat _rolingInterval;
    BOOL _isTimeup;
}

@property (assign, nonatomic) NSInteger centerImageIndex;
@property (assign, nonatomic) NSInteger leftImageIndex;
@property (assign, nonatomic) NSInteger rightImageIndex;
@property (assign, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIImageView *leftImageView;
@property (strong, nonatomic) UIImageView *centerImageView;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIScrollView *bannerScrollView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSArray *imageLinkURL;
@property (strong, nonatomic) NSArray *bannerTitleArray;
@property (copy, nonatomic) NSString *placeHolder;

@end

@implementation XFBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _rolingInterval = 3.0f;
        _bannerScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _bannerScrollView.bounces = NO;
        _bannerScrollView.delegate = self;
        _bannerScrollView.pagingEnabled = YES;
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        _bannerScrollView.backgroundColor = [UIColor whiteColor];
        _bannerScrollView.contentOffset = CGPointMake(kAdViewWidth, 0);
        _bannerScrollView.contentSize = CGSizeMake(kAdViewWidth * 3, kAdViewHeight);
        _bannerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kAdViewWidth, kAdViewHeight)];
        _leftImageView.contentMode = UIViewContentModeScaleToFill;
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdViewWidth, 0, kAdViewWidth, kAdViewHeight)];
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapped)]];
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kAdViewWidth * 2, 0, kAdViewWidth, kAdViewHeight)];
        _rightImageView.contentMode = UIViewContentModeScaleToFill;
        
        [_bannerScrollView addSubview:_leftImageView];
        [_bannerScrollView addSubview:_centerImageView];
        [_bannerScrollView addSubview:_rightImageView];
        
        [self addSubview:_bannerScrollView];
    }
    return self;
}

-(void) willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setupTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (_imageLinkURL.count > 1){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_rolingInterval target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
        _isTimeup = NO;
    }
}

+ (XFBannerView*)initBannerViewWithFrame:(CGRect)frame
                            imageLinkURL:(NSArray*)imageLinkURL
                           subtitleArray:(NSArray*)subtitles
                     placeHoderImageName:(NSString*)placeHolder
                            bannerTapped:(void(^)(NSInteger index)) tapped
{
    if(imageLinkURL.count == 0) return nil;
    XFBannerView *banner = [[XFBannerView alloc]initWithFrame:frame];
    banner.placeHolder = placeHolder;
    banner.bannerTapped = tapped;
    [banner setimageLinkURL:imageLinkURL];
    [banner setSubtitleArray:subtitles];
    [banner setPageControl];
    return banner;
}

+ (XFBannerView*)initBannerViewWithFrame:(CGRect)frame
                       localImagePath:(NSArray*)localImagePath
                           subtitleArray:(NSArray*)subtitles
                            bannerTapped:(void(^)(NSInteger index)) tapped
{
    if(localImagePath.count == 0) return nil;
    NSMutableArray *imagePaths = [[NSMutableArray alloc]init];
    for(NSString *imageName in localImagePath)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        NSURL *imageURL = [NSURL fileURLWithPath:path];
        [imagePaths addObject:imageURL];
    }
    XFBannerView *banner = [[XFBannerView alloc]initWithFrame:frame];
    banner.bannerTapped = tapped;
    [banner setimageLinkURL:imagePaths];
    [banner setSubtitleArray:subtitles];
    [banner setPageControl];
    return banner;
}

- (void)setimageLinkURL:(NSArray *)imageLinkURL
{
    _imageLinkURL = imageLinkURL;
    self.leftImageIndex = _imageLinkURL.count - 1;
    self.centerImageIndex = 0;
    self.rightImageIndex = 1;
    if (_imageLinkURL.count < 2) {
        _bannerScrollView.scrollEnabled = NO;
        self.rightImageIndex = 0;
        if (self.centerImageIndex < _imageLinkURL.count) {
            [_centerImageView sd_setImageWithURL:_imageLinkURL[self.centerImageIndex] placeholderImage:[UIImage imageNamed:self.placeHolder]];
        }
    }else{
        _bannerScrollView.scrollEnabled = YES;
        [self renderImages];
    }
    [self setupTimer];
}

- (void)setSubtitleArray:(NSArray *)subtitleArray
{
    _bannerTitleArray = subtitleArray;
    if (self.titleLabel) {
        [self.titleLabel removeFromSuperview];
        self.titleLabel = nil;
    }
    if(_bannerTitleArray.count == 0) return;
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    if (self.centerImageIndex < _bannerTitleArray.count) {
        self.titleLabel.text = _bannerTitleArray[self.centerImageIndex];
    }
    NSInteger spacing = 0;
    if (self.pageControl) {
        spacing = self.pageControl.frame.size.width;
    }
    self.titleLabel.frame = CGRectMake(10, kAdViewHeight - 25, kAdViewWidth - spacing - 22, 20);
    [self addSubview:self.titleLabel];
}

- (void)setPageControl
{
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
        self.pageControl = nil;
    }
    if (_imageLinkURL.count < 2) return;
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = _imageLinkURL.count;
    self.pageControl.frame = CGRectMake(0, 0, 20 * _pageControl.numberOfPages, 20);
    self.pageControl.center = CGPointMake(kAdViewWidth / 2.0, kAdViewHeight - 10);
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = NO;
    [self addSubview:_pageControl];
}

- (void)timerTick:(NSTimer*)timer
{
    [_bannerScrollView setContentOffset:CGPointMake(kAdViewWidth * 2, 0) animated:YES];
    _isTimeup = YES;
    [NSTimer scheduledTimerWithTimeInterval:0.4f target:self selector:@selector(scrollViewDidEndDecelerating:) userInfo:nil repeats:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_bannerScrollView.contentOffset.x == 0){
        self.centerImageIndex --;
        self.leftImageIndex --;
        self.rightImageIndex --;
        if (self.leftImageIndex < 0) {
            self.leftImageIndex = _imageLinkURL.count - 1;
        }
        if (self.centerImageIndex < 0){
            self.centerImageIndex = _imageLinkURL.count - 1;
        }
        if (self.rightImageIndex < 0){
            self.rightImageIndex = _imageLinkURL.count - 1;
        }
    }else if(_bannerScrollView.contentOffset.x == kAdViewWidth * 2) {
        self.centerImageIndex ++;
        self.leftImageIndex ++;
        self.rightImageIndex ++;
        if (self.leftImageIndex >= _imageLinkURL.count) {
            self.leftImageIndex = 0;
        }
        if (self.centerImageIndex >= _imageLinkURL.count){
            self.centerImageIndex = 0;
        }
        if (self.rightImageIndex >= _imageLinkURL.count){
            self.rightImageIndex = 0;
        }
    }else {
        return;
    }
    
    [self renderImages];
    self.pageControl.currentPage = self.centerImageIndex;
    if (_bannerTitleArray && _bannerTitleArray.count > 0){
        if (self.centerImageIndex < _bannerTitleArray.count){
            self.titleLabel.text = _bannerTitleArray[self.centerImageIndex];
        }
    }
    _bannerScrollView.contentOffset = CGPointMake(kAdViewWidth, 0);
    if (!_isTimeup) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_rolingInterval]];
    }
    _isTimeup = NO;
}

- (void)renderImages
{
    if (self.leftImageIndex < _imageLinkURL.count) {
        [_leftImageView sd_setImageWithURL:_imageLinkURL[self.leftImageIndex] placeholderImage:[UIImage imageNamed:self.placeHolder]];
    }
    
    if (self.centerImageIndex < _imageLinkURL.count) {
        [_centerImageView sd_setImageWithURL:_imageLinkURL[self.centerImageIndex] placeholderImage:[UIImage imageNamed:self.placeHolder]];
    }
    
    if (self.rightImageIndex < _imageLinkURL.count) {
        [_rightImageView sd_setImageWithURL:_imageLinkURL[self.rightImageIndex] placeholderImage:[UIImage imageNamed:self.placeHolder]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

-(void)OnTapped
{
    if (self.bannerTapped){
        self.bannerTapped(self.centerImageIndex);
    }
}

- (void)refreshBannerWithImageUrls:(NSArray*)imageUrls
{
    [self setimageLinkURL:imageUrls];
    [self setPageControl];
}

-(void)remove
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self removeFromSuperview];
}

@end
