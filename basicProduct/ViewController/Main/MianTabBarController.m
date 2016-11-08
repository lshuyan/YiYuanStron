//
//  MianTabBarController.m
//  basicProduct
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MianTabBarController.h"
#import "MainViewController.h"

@interface MianTabBarController ()

@end

@implementation MianTabBarController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
       
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *viewControlller0 = [[MainViewController alloc] init];
    viewControlller0.title = @"发现";
    MainViewController *viewControlller1 = [[MainViewController alloc] init];
    viewControlller1.title = @"购物";
    MainViewController *viewControlller2 = [[MainViewController alloc] init];
    viewControlller2.title = @"夺宝";
    MainViewController *viewControlller3 = [[MainViewController alloc] init];
    viewControlller3.title = @"我的";
    self.viewControllers = @[viewControlller0, viewControlller1, viewControlller2, viewControlller3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
