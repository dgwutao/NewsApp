//
//  AppGuideView.m
//  
//
//  Created by xf on 17/10/24.
//  Copyright (c) 2017年 xf. All rights reserved.
//

#import "AppGuideView.h"

@interface AppGuideView ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *imageViews;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation AppGuideView

- (void) layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    for (NSInteger i = 0; i < self.imageViews.count; i ++) {
        UIImageView *imageView = [self.imageViews objectAtIndex:i];
        imageView.frame = CGRectMake(i * self.frame.size.width, 0.0f, self.frame.size.width, self.frame.size.height);
    }
}

- (UIScrollView *) scrollView{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    
    return _scrollView;
}

- (void) setGuideImages:(NSArray *)images{
    if (images.count == 0) return;
    
    _guideImages = images;
    self.scrollView.contentSize = CGSizeMake((images.count + 1) * self.frame.size.width , self.frame.size.height);
    NSMutableArray *array = [NSMutableArray array];
    for (UIImage *image in images) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.scrollView addSubview:imageView];
        [array addObject:imageView];
    }
    
    _imageViews = [NSArray arrayWithArray:array];
//    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20 - 10, SCREEN_WIDTH, 20)];
//    self.pageControl.numberOfPages = images.count;
//    self.pageControl.currentPage = 0;
//    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    [self addSubview:self.pageControl];
    [self setNeedsDisplay];
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= scrollView.frame.size.width * self.guideImages.count) {
        if (self.scrollEndBlock) {
            self.scrollEndBlock();
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.guideBlock) {
        self.guideBlock((int)self.pageControl.currentPage);
    }
}

- (void)dealloc {
    DebugLog(@"%@没有造成循环引用", [self class]);
}
@end
