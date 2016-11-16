//
//  BasicViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setNavigtion
{
    self.mainNavController = [[MainNavigationController alloc] initWithRootViewController:self];
}


- (void)addNavBackItme
{
    @weakify(self)
    [self addNavLeftItmeForTitle:@"返回" block:^(id x) {
        [self_weak_.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)addNavLeftItmeForTitle:(NSString *)title block:(void(^)(id x))block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:block];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:0];
    [button sizeToFit];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = itme;
}

@end
