//
//  ViewController.m
//  ShoppingCartAnimation
//
//  Created by Joye on 2017/9/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

#import "ViewController.h"

#import "YJShoppingCartView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView
{
    YJShoppingCartView *tableView = [[YJShoppingCartView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-80) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
}

@end
