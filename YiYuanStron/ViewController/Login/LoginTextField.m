//
//  LoginTextField.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/17.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "LoginTextField.h"
#import "UIColor+Extern.h"

@implementation LoginTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:16];
    self.borderStyle = 0;
    self.clearButtonMode = UITextFieldViewModeAlways;
    
    UIView *view = [[UIView alloc] init];
    view.userInteractionEnabled = NO;
    view.backgroundColor = [UIColor colorWithHexString:@"e1e2e3"];
    self.lineView  = view;
    //灰色线
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@(-10));
        make.right.equalTo(@10);
        make.height.equalTo(@2);
    }];

}

@end
