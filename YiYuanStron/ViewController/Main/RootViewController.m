//
//  RootViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/9.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "RootViewController.h"
#import "MainTabBarController.h"
#import "LeftViewController.h"
#import "MainNavigationController.h"

@interface RootViewController ()

@property (nonatomic, strong)LeftViewController                           *leftViewController;
@property (nonatomic, strong)MainTabBarController                      *mainController;
@property (nonatomic, strong)MainNavigationController                 *mainNvaController;

@property (nonatomic, strong)UIControl                                          *mainMarkConntrol;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildController];
}

- (void)addChildController
{
    self.leftViewController = [[LeftViewController alloc] init];
    self.mainController = [[MainTabBarController alloc] init];
    [self addChildViewController:self.mainNvaController];
    [self.view addSubview:self.mainNvaController.view];
    self.mainNvaController.view.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- 事件

- (void)onTouchLeftItme
{
    [self showLeftViewController];
}

#pragma mark ------------- 自定义方法

- (void)showLeftViewController
{
    [self addChildViewController:self.leftViewController];
    [self.view insertSubview:self.leftViewController.view atIndex:0];
    
    [self.mainNvaController.view addSubview:self.mainMarkConntrol];
     [UIView animateWithDuration:.2 animations:^{
        CGPoint point = self.mainNvaController.view.center;
        point.x += kSCREEN_WIGHT*.8;
        self.mainNvaController.view.center = point;
    }];
}

- (void)showMainController
{
    [self.leftViewController willMoveToParentViewController:nil];
    [self.mainMarkConntrol removeFromSuperview];
    [UIView animateWithDuration:.2 animations:^{
        CGPoint point = self.mainNvaController.view.center;
        point.x = kSCREEN_WIGHT*.5;
        self.mainNvaController.view.center = point;
    } completion:^(BOOL finished) {
        [self.leftViewController removeFromParentViewController];
    }];
}

#pragma mark ------------- set get

- (MainNavigationController *)mainNvaController
{
    if (!_mainNvaController) {
        _mainNvaController = [[MainNavigationController alloc] initWithRootViewController:self.mainController];
        UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStyleDone target:self action:@selector(onTouchLeftItme)];
        self.mainController.navigationItem.leftBarButtonItem = itme;
    }
    return _mainNvaController;
}

- (UIControl *)mainMarkConntrol
{
    if (!_mainMarkConntrol) {
        _mainMarkConntrol = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        @weakify(self)
        [[_mainMarkConntrol rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self_weak_ showMainController];
        }];
//        _mainMarkConntrol.rac_command;
        
    }
    return _mainMarkConntrol;
}

@end
