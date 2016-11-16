//
//  MainNavigationController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/9.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong)id<UIGestureRecognizerDelegate>                    popGestureDelegate;

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
    }else {
        self.interactivePopGestureRecognizer.delegate = nil;
    } 
}

@end
