//
//  YJShoppingCartCell.m
//  ShoppingCartAnimation
//
//  Created by Joye on 2017/9/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJShoppingCartCell.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface YJShoppingCartCell ()

@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIImageView *pictureIV;

@end

@implementation YJShoppingCartCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"cell_id";
    YJShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YJShoppingCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    imageV.image = [UIImage imageNamed:@"wonan.jpg"];
    [self.contentView addSubview:imageV];
    self.pictureIV = imageV;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH-60, 20, 40, 40)];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
    self.addBtn = button;
}

- (void)addBtnClick
{
    self.addBtnBlock();
}

- (void)configAnimationWithIndexPath:(NSIndexPath *)indexPath contentY:(CGFloat)offsetY
{
    CGPoint fromP = CGPointMake(self.addBtn.center.x, self.center.y-offsetY);
    CGPoint toP = CGPointMake(30, HEIGHT - 30);
    NSLog(@"from----%f,%f",fromP.x,fromP.y);
    NSLog(@"to----%f,%f",toP.x,toP.y);
    [self startAnimationWithImage:self.pictureIV.image fromPoint:fromP toPoint:toP endBlock:nil];
}

- (void)startAnimationWithImage:(UIImage *)goodsImage
                      fromPoint:(CGPoint)fromPoint
                        toPoint:(CGPoint)toPoint
                       endBlock:(void(^)())block
{
    //------- 创建shapeLayer -------
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(fromPoint.x - 20, fromPoint.y - 20, 40, 40);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    [rootVC.view.layer addSublayer:animationLayer];
    
    //------- 创建移动轨迹 -------
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(100,100)];
    
    // 轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.path = movePath.CGPath;
    
    
    //------- 创建缩小动画 -------//
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.7];
    scaleAnimation.duration = 1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    
    // 添加轨迹动画
    [animationLayer addAnimation:pathAnimation forKey:nil];
    // 添加缩小动画
    [animationLayer addAnimation:scaleAnimation forKey:nil];
    
}

@end
