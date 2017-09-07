//
//  YJScrollView.h
//
//  Created by Joye on 2017/9/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJScrollView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)array;

typedef void(^Timer_NextPageBlock)();
typedef void(^ScrollViewDidScrollBlock)(CGFloat offsetX);

@property (nonatomic, copy) Timer_NextPageBlock timerBlock;
@property (nonatomic, copy) ScrollViewDidScrollBlock didScrollBlock;

@end

@interface YJPageControl : UIPageControl

@property (nonatomic, assign) NSInteger number;

- (instancetype)initWithFrame:(CGRect)frame pageNum:(NSInteger)number;

@end
