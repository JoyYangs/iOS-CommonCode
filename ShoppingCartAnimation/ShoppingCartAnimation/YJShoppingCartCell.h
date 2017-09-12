//
//  YJShoppingCartCell.h
//  ShoppingCartAnimation
//
//  Created by Joye on 2017/9/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJShoppingCartCell : UITableViewCell

typedef void(^AddBtnClickBlock)();
@property (nonatomic, copy) AddBtnClickBlock addBtnBlock;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)configAnimationWithIndexPath:(NSIndexPath *)indexPath contentY:(CGFloat)offsetY;

@end
