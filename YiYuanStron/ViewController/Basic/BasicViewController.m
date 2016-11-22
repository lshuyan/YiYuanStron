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
    [self addNavLeftItmeForTitle:nil image:@"back_black" block:^(id x) {
        [self_weak_ backToViewController];
    }];
}

- (void)backToViewController
{
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)addNavLeftItmeForTitle:(NSString *)title  image:(NSString *)image block:(void(^)(id x))block
{
    UIBarButtonItem *itme = [self createBarButtonItemForTitle:title image:image block:block];
    self.navigationItem.leftBarButtonItem = itme;
}

- (void)addNavRightItmeForTitle:(NSString *)title  image:(NSString *)image block:(void(^)(id x))block
{
    UIBarButtonItem *itme = [self createBarButtonItemForTitle:title image:image block:block];
    self.navigationItem.rightBarButtonItem = itme;
}

- (void)addRightRightItmesForTitles:(NSArray *)titles  images:(NSArray *)images block:(void(^)(id x))block
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSInteger a= 0;
    for (NSString *title in titles) {
        UIBarButtonItem *itme = [self createBarButtonItemForTitle:title image:nil block:block];
        itme.customView.tag = a;
        [arr addObject:itme];
        a++;
    }
    for (NSString *image in images) {
        UIBarButtonItem *itme = [self createBarButtonItemForTitle:nil image:image block:block];
        itme.customView.tag = a;
        [arr addObject:itme];
        a++;
    }
    
    [self.navigationItem setRightBarButtonItems:arr];
}

- (void)addNavTitilImage:(NSString *)image
{
    UIImageView *view = [[UIImageView alloc] init];
    view.contentMode = UIViewContentModeCenter;
    view.image = [UIImage imageNamed:image];
    [view sizeToFit];
    self.navigationItem.titleView = view;
}

#pragma mark ------------- 

- (UIBarButtonItem *)createBarButtonItemForTitle:(NSString *)title  image:(NSString *)image block:(void(^)(id x))block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (block) {
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:block];
    }
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:0];
    }
    if (image){
        [button setImage:[UIImage imageNamed:image] forState:0];
    }
    [button sizeToFit];
//    button.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:button];
    return  itme;
}

@end
