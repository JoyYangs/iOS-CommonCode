//
//  YJScrollView.m
//
//  Created by Joye on 2017/9/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJScrollView.h"

@interface YJScrollView () <UIScrollViewDelegate>

@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YJScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = array;
        self.count = array.count;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.delegate = self;
    self.pagingEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(self.count * self.frame.size.width, 100);
    
    for (int i=0; i<self.count; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        imageV.backgroundColor = self.imageArray[i];
        [self addSubview:imageV];
    }
    
    [self addTimer];
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

- (void)pauseTimer
{
    [self.timer invalidate];
}

- (void)nextPage
{
    self.timerBlock();
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.didScrollBlock(scrollView.contentOffset.x);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

// 此处采用的本地图片的方式(用color代替)，如果是网络请求图片的话、就把添加imageView和timer的方法放在获取到网络图片之后即可

@end



@implementation YJPageControl

- (instancetype)initWithFrame:(CGRect)frame pageNum:(NSInteger)number
{
    self = [super initWithFrame:frame];
    if (self) {
        self.number = number;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.numberOfPages = self.number;
    self.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageIndicatorTintColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
}

@end
