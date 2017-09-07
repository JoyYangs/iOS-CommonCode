//
//  ViewController.m
//
//  Created by Joye on 2017/9/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ViewController.h"

#import "YJScrollView.h"

@interface ViewController ()

@property (nonatomic, strong) YJPageControl *pageCon;
@property (nonatomic, strong) YJScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    NSArray *array = @[[UIColor greenColor],
                       [UIColor redColor],
                       [UIColor cyanColor],
                       [UIColor orangeColor],
                       [UIColor yellowColor]
                       ];
    
    YJScrollView *scrollView = [[YJScrollView alloc] initWithFrame:CGRectMake(0, 64, width, 200) imageArray:array];
    
    YJPageControl *pageCon = [[YJPageControl alloc] initWithFrame:CGRectMake(0, 234, width, 10) pageNum:array.count];
    [self.view addSubview:scrollView];
    [self.view addSubview:pageCon];
    self.scrollView = scrollView;
    self.pageCon = pageCon;
    
    __weak typeof(self) weak_self = self;
    scrollView.timerBlock = ^{
        int page = (int)weak_self.pageCon.currentPage;
        if (page == array.count-1) page = 0;
        else page ++;
        weak_self.scrollView.contentOffset = CGPointMake(width * page, 0);
    };
    
    scrollView.didScrollBlock = ^(CGFloat offsetX) {
        int c_page = offsetX / width;
        weak_self.pageCon.currentPage = c_page;
    };
}


@end
