//
//  UIView+EX.h
//
//  Created by Glex on 13-7-19.
//  Copyright (c) 2013年 KOTO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewEx)

@property (nonatomic, weak) id userData;

@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat bottom;

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

/**
 *  可能为nil
 */
@property (nonatomic, weak, readonly) UIImageView *bgImageView;

/**
 *  设置背景，创建一个图片控件 bgImageView，[image stretch];
 *
 */
- (void)setBgImageWithStretchImage:(UIImage *)image;

/**
 *  设置背景，创建一个图片控件 bgImageView，bgImageView.viewContentMode = ScaleAspectFill
 *
 */
- (void)setBgImageWithScaleAspectFillImage:(UIImage *)image;

/**
 *  使用图片pattern模式 设置背景颜色
 *
 */
- (void)setBgColorWithImage:(UIImage *)image;

/**
 *  递归设置子视图的背景颜色(随机颜色)，通常在用测试时使用
 */
- (void)setSubViewBgColor;

@end
