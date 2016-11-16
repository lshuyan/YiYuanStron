//
//  appMagagerSingle.h
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppMagagerSingle : NSObject

/**  屏幕比例,    比例基于iPhone6 (4.7寸)布局使用.   已经初始化好
 *
 **/
@property(nonatomic, assign)CGFloat         screenScaleFor6;

/**
 *   左边页面打开时,   主页的缩进比例
 **/
@property (nonatomic, assign)CGFloat        mainContollerLeftScale;

+ (instancetype)shareManager;

@end
