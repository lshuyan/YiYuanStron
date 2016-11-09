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

- (void)makeForItemModels:(NSArray *)arr callBackBlock:(VoidBlock_id)block;

@end
