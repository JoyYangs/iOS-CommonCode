//
//  ViewController.m
//
//  Created by Joye on 2017/8/29.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *backView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSegment];
}

- (void)setupSegment
{
    NSArray *segmentArray = @[@"私信",@"评论",@"@我",@"通知"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:segmentArray];
    segment.frame = CGRectMake(30, 100, 320, 30);
    segment.backgroundColor = [UIColor whiteColor];
    
    segment.layer.borderWidth = 1.0;
    segment.layer.cornerRadius = 15;
    segment.layer.borderColor = [UIColor grayColor].CGColor;
    
    segment.tintColor = [UIColor clearColor];
    NSDictionary *selectedTextAttributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
        NSForegroundColorAttributeName: [UIColor whiteColor]};
    [segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary *unselectedTextAttributes = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
        NSForegroundColorAttributeName:[UIColor grayColor]};
    [segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    backView.backgroundColor = [UIColor lightGrayColor];
    backView.layer.cornerRadius = 15;
    [segment addSubview:backView];
    self.backView = backView;
}

- (void)segmentClicked:(UISegmentedControl *)segment
{
    [UIView animateWithDuration:0.2 animations:^{
        self.backView.transform = CGAffineTransformMakeTranslation(80*segment.selectedSegmentIndex, 0);
    } completion:nil];
    
    // other code
}

@end
