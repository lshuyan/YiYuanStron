//
//  OrderTableHeadView.h
//  YiYuanStron
//
//  Created by ybjy on 16/11/23.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAddressView.h"

@interface OrderTableHeadView : UIView

@property(nonatomic, strong) UIView                  *addressContentView;
@property (nonatomic, strong)UserAddressView *userAddressView;
@property(nonatomic, strong) UIView                  *productContentView;

@end
