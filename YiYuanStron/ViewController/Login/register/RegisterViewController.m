//
//  RegisterViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/17.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+Extern.h"
#import "LoginTextField.h"

@interface RegisterViewController ()

@property (nonatomic, strong)UILabel                 *topLable;//上
@property (nonatomic, strong)UITextField           *numberField; //账号
@property (nonatomic, strong)UITextField           *checkField; //验证码
@property (nonatomic, strong)UITextField           *passwordField; //密码
@property (nonatomic, strong)UILabel                 *middleLable;//中间
@property (nonatomic, strong)UIButton                *doneButton; //确定
@property (nonatomic, strong)UILabel                  *bottomLable;//
@property (nonatomic, strong)UIButton                *loginButton; //注册

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topLable];
    [self.view addSubview:self.numberField];
//    [self.view addSubview:self.topLable];
//    [self.view addSubview:self.topLable];
    
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(15 * kSCREEN_6));
    }];
    [self.numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@(15 * kSCREEN_6));
        make.top.equalTo(self.topLable.mas_bottom).offset(-10 * kSCREEN_6);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- set get

- (UILabel *)topLable
{
    if (!_topLable) {
        _topLable = [self createLabel];
        _topLable.text = @"我们将发送验证码到您的手机。";
    }
    return _topLable;
}

- (UITextField *)numberField
{
    if (!_numberField) {
        _numberField = [[LoginTextField alloc] init];
        _numberField.placeholder = @"请填写注册手机号";
        _numberField.keyboardType = UIKeyboardTypeNumberPad;
        _numberField.returnKeyType = UIReturnKeyNext;
        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"手机号";
        _numberField.leftView = label;
    }
    return  _numberField;
}

- (UILabel *)middleLable
{
    if (!_middleLable) {
        _middleLable = [self createLabel];
        _middleLable.text = @"说明：注册即视为同意易源商城服务条款";
    }
    return _middleLable;
}

- (UILabel *)bottomLable
{
    if (!_bottomLable) {
        _bottomLable = [self createLabel];
        _bottomLable.text = @"已有帐号吗？";
    }
    return _bottomLable;
}


#pragma mark -------------   没用的

- (UILabel *)createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"999999"];
    return label;
}

@end
