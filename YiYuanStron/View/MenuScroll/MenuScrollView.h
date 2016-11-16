//
//  MenuScrollView.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/10.
//  Copyright © 2016年 huyan. All rights reserved.
//
//  横向滑动菜单栏
//  创建说明
//  xx alloc  init


#import <UIKit/UIKit.h>
#import "MenuItmeModel.h"

@interface MenuScrollView : UIView

// 再调用一下方法
// arr    包含(menuItmeModle)的数组
// block 点击事件回调
- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block;

@end
