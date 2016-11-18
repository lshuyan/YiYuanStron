//
//  RegisterViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/17.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+Extern.h"
#import "UIImage+FitSize.h"
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
    
    if (self.isRegister) {
        self.title = @"手机注册";
    }else{
        self.title = @"忘记密码";
    }
    
    [self.view addSubview:self.topLable];
    [self.view addSubview:self.numberField];
    [self.view addSubview:self.checkField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.doneButton];
    if (self.isRegister) {
        [self.view addSubview:self.middleLable];
        [self.view addSubview:self.bottomLable];
        [self.view addSubview:self.loginButton];
    }
    
    [self.topLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(15 * kSCREEN_6));
    }];
    [self.numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(self.topLable.mas_bottom).offset(10 * kSCREEN_6);
    }];
    [self.checkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(self.numberField.mas_bottom).offset(13 * kSCREEN_6);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(self.checkField.mas_bottom).offset(13 * kSCREEN_6);
    }];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*kSCREEN_6));
        make.right.equalTo(@(-15*kSCREEN_6));
        make.height.equalTo(@(42));
        make.top.equalTo(self.passwordField.mas_bottom).offset(112*kSCREEN_6);
    }];
    if (self.isRegister) {
        [self.middleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(25 * kSCREEN_6));
            make.top.equalTo(self.passwordField.mas_bottom).offset(12 * kSCREEN_6);
        }];
        [self.bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.loginButton.mas_left).offset(-4*kSCREEN_6);
            make.centerY.equalTo(self.loginButton.mas_centerY);
        }];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15*kSCREEN_6));
            make.height.equalTo(@(20));
            make.width.equalTo(@(40));
            make.top.equalTo(self.doneButton.mas_bottom).offset(9*kSCREEN_6);
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- 重写

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark ------------- 私有事件

#pragma mark ------------- 点击事件

/**
 *    登录按钮事件
 **/
- (void)onClickInjoyButtion
{
    [self.view endEditing:YES];
    NSLog(@"onClickInjoyButtion");
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
        label.text = @"手机号   ";
        [label sizeToFit];
        _numberField.leftView = label;
        _numberField.leftViewMode=UITextFieldViewModeAlways;

    }
    return  _numberField;
}

- (UITextField *)checkField
{
    if (!_checkField) {
        _checkField = [[LoginTextField alloc] init];
        _checkField.placeholder = @"短信验证码";
        _checkField.keyboardType = UIKeyboardTypeNumberPad;
        _checkField.returnKeyType = UIReturnKeyNext;

        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"验证码   ";
        [label sizeToFit];
        _checkField.leftView = label;
        _checkField.leftViewMode = UITextFieldViewModeAlways;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@" 获取验证码" forState:0];
        [button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button addTarget:self action:@selector(onClickInjoyButtion) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        button.backgroundColor
        = [UIColor orangeColor];
        _checkField.rightView = button;
        _checkField.rightViewMode = UITextFieldViewModeAlways;
    }
    return  _checkField;
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[LoginTextField alloc] init];
        _passwordField.placeholder = @"6-20位数符";
        _passwordField.keyboardType = UIKeyboardTypeDefault;
        _passwordField.returnKeyType = UIReturnKeyNext;
        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"设置密码   ";
        [label sizeToFit];
        _passwordField.leftView = label;
        _passwordField.leftViewMode=UITextFieldViewModeAlways;
    }
    return  _passwordField;
}

- (UILabel *)middleLable
{
    if (!_middleLable) {
        _middleLable = [self createLabel];
        _middleLable.text = @"说明：注册即视为同意易源商城服务条款";
    }
    return _middleLable;
}

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.backgroundColor = COLOR_O;
        [_doneButton setTitle:@"确  定" forState:0];
        [_doneButton setTitle:@"确  定" forState:UIControlStateDisabled];
        [_doneButton setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:0];
        [_doneButton setTitleColor:[UIColor colorWithHexString:@"c7c7cc"] forState:UIControlStateDisabled];
        [_doneButton setBackgroundImage:[UIImage imageWithColor:COLOR_O] forState:0];
        [_doneButton setBackgroundImage:[UIImage imageWithColor:COLOR_STRING(@"e8e8e8")] forState:UIControlStateDisabled];
        _doneButton.enabled = NO;
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_doneButton addTarget:self action:@selector(onClickInjoyButtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _doneButton;
}

- (UILabel *)bottomLable
{
    if (!_bottomLable) {
        _bottomLable = [self createLabel];
        _bottomLable.text = @"已有帐号吗？";
    }
    return _bottomLable;
}

- (UIButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitle:@"登录" forState:0];
        [_loginButton setTitleColor:[UIColor colorWithHexString:@"f39800"] forState:0];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.borderWidth = 1;
        _loginButton.layer.borderColor = [UIColor colorWithHexString:@"f39800"].CGColor;
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_loginButton addTarget:self action:@selector(onClickInjoyButtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _loginButton;
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
