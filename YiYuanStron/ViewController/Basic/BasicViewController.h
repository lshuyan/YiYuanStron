//
//  BasicViewController.h
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainNavigationController.h"

@interface BasicViewController : UIViewController

@property (nonatomic, strong)MainNavigationController                         *mainNavController;

//设置为导航的rootview;
- (void)setNavigtion;

/**
 *    增加返回按钮
 **/
- (void)addNavBackItme;
- (void)addNavLeftItmeForTitle:(NSString *)title  image:(NSString *)image block:(void(^)(id x))block;

//返回
- (void)backToViewController;

//标题
- (void)addNavTitilImage:(NSString *)image;

- (void)addRightRightItmesForTitles:(NSArray *)titles  images:(NSArray *)images block:(void(^)(id x))block;

// 创建UIBarButtonItem;
- (UIBarButtonItem *)createBarButtonItemForTitle:(NSString *)title  image:(NSString *)image block:(void(^)(id x))block;

@end
