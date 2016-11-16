//
//  BannerScrollView.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerItemModel.h"

@interface BannerScrollView : UIView

// 再调用一下方法
// arr    包含(BannerItemModel)的数组
// block 点击事件回调
- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block;

@end
