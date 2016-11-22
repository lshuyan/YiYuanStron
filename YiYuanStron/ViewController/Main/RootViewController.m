//
//  RootViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/9.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
//#import "LeftViewController.h"
#import "VipContentViewController.h"

@interface RootViewController ()

@property (nonatomic, strong)VipContentViewController                *leftViewController;
@property (nonatomic, strong)MainViewController                          *mainController;

@property (nonatomic, strong)UIControl                                          *mainMarkConntrol;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildController];
}

- (void)addChildController
{
    self.leftViewController = [[VipContentViewController alloc] init];
    self.mainController = [[MainViewController alloc] init];
    [self.mainController setNavigtion];
    @weakify(self)
    [self.mainController addNavLeftItmeForTitle:nil image:@"hont_nav_left" block:^(id x) {
        [self_weak_ showLeftViewController];
    }];
    
    [self addChildViewController:self.mainController.navigationController];
    [self.view addSubview:self.mainController.navigationController.view];
    self.mainController.navigationController.view.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- 自定义方法

- (void)showLeftViewController
{
    [self addChildViewController:self.leftViewController];
    [self.view insertSubview:self.leftViewController.view atIndex:0];
    [self.mainController.navigationController.view addSubview:self.mainMarkConntrol];
    [self.leftViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(@0);
        make.width.equalTo(@(kSCREEN_WIGHT*[AppMagagerSingle shareManager].mainContollerLeftScale));
    }];

    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGPoint point = self.mainController.navigationController.view.center;
        point.x += kSCREEN_WIGHT*[AppMagagerSingle shareManager].mainContollerLeftScale;
        self.mainController.navigationController.view.center = point;
    } completion:nil];
}

- (void)showMainController
{
    [self.leftViewController willMoveToParentViewController:nil];
    [self.mainMarkConntrol removeFromSuperview];
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint point = self.mainController.navigationController.view.center;
        point.x = kSCREEN_WIGHT*.5;
        self.mainController.navigationController.view.center = point;
    } completion:^(BOOL finished) {
        [self.leftViewController removeFromParentViewController];
    }];
}

#pragma mark ------------- set get

- (UIControl *)mainMarkConntrol
{
    if (!_mainMarkConntrol) {
        _mainMarkConntrol = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        @weakify(self)
        [[_mainMarkConntrol rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self_weak_ showMainController];
        }];        
    }
    return _mainMarkConntrol;
}

@end
