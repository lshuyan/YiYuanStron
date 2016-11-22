//
//  OptionItme.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/22.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "OptionItme.h"
#import "UIColor+Extern.h"

@implementation OptionItme

+(instancetype)buttonWithType:(UIButtonType)buttonType
{
    OptionItme *itme = [super  buttonWithType:buttonType];
    [itme initUI];
    return itme;
}

- (void)initUI
{
    UIImage *image0 = [[UIImage imageNamed:@"option_itme_0"] stretchableImageWithLeftCapWidth:13 topCapHeight:8];
    UIImage *image1 = [[UIImage imageNamed:@"option_itme_1"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
    [self setBackgroundImage:image0 forState:0];
    [self setBackgroundImage:image1 forState:UIControlStateSelected];
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:COLOR_STRING(@"ffffff") forState:0];
}

@end
