//
//  YJShoppingCartView.m
//  ShoppingCartAnimation
//
//  Created by Joye on 2017/9/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "YJShoppingCartView.h"

#import "YJShoppingCartCell.h"

@implementation YJShoppingCartView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView
{
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = 80;
    self.separatorInset = UIEdgeInsetsZero;
    self.separatorColor = [UIColor greenColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YJShoppingCartCell *cell = [YJShoppingCartCell cellWithTableView:tableView];
    __weak typeof(cell) weakcell = cell;
    cell.addBtnBlock = ^{
        [weakcell configAnimationWithIndexPath:indexPath contentY:self.contentOffset.y];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
