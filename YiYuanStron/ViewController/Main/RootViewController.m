//
//  RootViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/9.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "OptionViewController.h"
#import "VipContentViewController.h"

@interface RootViewController ()

@property (nonatomic, strong)VipContentViewController                *leftViewController;//left
@property (nonatomic, strong)MainViewController                          *mainController;
@property (nonatomic, strong)OptionViewController                       *optionViewController;//right

@property (nonatomic, strong)UIControl                                          *mainMarkConntrol;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildController];
}

- (void)addChildController
{
    self.mainController = [[MainViewController alloc] init];
    [self.mainController setNavigtion];
    self.mainController.rootViewController = self;
    
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
    if (!self.leftViewController) {
        self.leftViewController = [[VipContentViewController alloc] init];
    }
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

- (void)showRightViewController
{
    if (!self.optionViewController) {
        self.optionViewController = [[OptionViewController alloc] init];
    }
    [self addChildViewController:self.optionViewController];
    [self.view insertSubview:self.optionViewController.view atIndex:0];
    [self.mainController.navigationController.view addSubview:self.mainMarkConntrol];
    [self.optionViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@0);
        make.width.equalTo(@(kSCREEN_WIGHT*[AppMagagerSingle shareManager].mainContollerLeftScale));
    }];
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGPoint point = self.mainController.navigationController.view.center;
        point.x -= kSCREEN_WIGHT*[AppMagagerSingle shareManager].mainContollerLeftScale;
        self.mainController.navigationController.view.center = point;
    } completion:nil];
}

- (void)showMainController
{
    [self.leftViewController willMoveToParentViewController:nil];
    [self.optionViewController willMoveToParentViewController:nil];
    [self.mainMarkConntrol removeFromSuperview];
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint point = self.mainController.navigationController.view.center;
        point.x = kSCREEN_WIGHT*.5;
        self.mainController.navigationController.view.center = point;
    } completion:^(BOOL finished) {
        [self.leftViewController.view removeFromSuperview];
        [self.optionViewController.view removeFromSuperview];
        [self.leftViewController removeFromParentViewController];
        [self.optionViewController removeFromParentViewController];
        self.leftViewController = nil;
        self.optionViewController = nil;
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
