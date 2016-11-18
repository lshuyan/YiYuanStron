//
//  EditPasswordViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/18.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "LoginTextField.h"
#import "UIColor+Extern.h"
#import "UIImage+FitSize.h"

@interface EditPasswordViewController ()

@property (nonatomic, strong)UITextField           *numberField; //账号
@property (nonatomic, strong)UITextField           *oldPasswordField; //原密码
@property (nonatomic, strong)UILabel                 *middleLable;//中间
@property (nonatomic, strong)UITextField           *newPasswordField; //新密码
@property (nonatomic, strong)UITextField           *new2PasswordField; //新2密码
@property (nonatomic, strong)UIButton                *doneButton; //确定

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self.view addSubview:self.numberField];
    [self.view addSubview:self.oldPasswordField];
    [self.view addSubview:self.middleLable];
    [self.view addSubview:self.newPasswordField];
    [self.view addSubview:self.new2PasswordField];
    [self.view addSubview:self.doneButton];
    
    [self.numberField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(@(39 * kSCREEN_6));
    }];
    [self.oldPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(self.numberField.mas_bottom).offset(13 * kSCREEN_6);
    }];
    [self.middleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15 * kSCREEN_6));
        make.top.equalTo(self.oldPasswordField.mas_bottom).offset(22 * kSCREEN_6);
    }];
    [self.newPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25 * kSCREEN_6));
        make.right.equalTo(@(-25 * kSCREEN_6));
        make.height.equalTo(@40);
        make.top.equalTo(self.middleLable.mas_bottom).offset(15 * kSCREEN_6);
    }];
    [self.new2PasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25*kSCREEN_6));
        make.right.equalTo(@(-25*kSCREEN_6));
        make.height.equalTo(@(40));
        make.top.equalTo(self.newPasswordField.mas_bottom).offset(13*kSCREEN_6);
    }];
    [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15*kSCREEN_6));
        make.left.equalTo(@(15));
        make.height.equalTo(@(42));
        make.top.equalTo(self.new2PasswordField.mas_bottom).offset(20*kSCREEN_6);
    }];

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

- (UITextField *)numberField
{
    if (!_numberField) {
        _numberField = [[LoginTextField alloc] init];
        _numberField.placeholder = @"请填写登录手机号";
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

- (UITextField *)oldPasswordField
{
    if (!_oldPasswordField) {
        _oldPasswordField = [[LoginTextField alloc] init];
        _oldPasswordField.placeholder = @"原登录密码";
        _oldPasswordField.keyboardType = UIKeyboardTypeNumberPad;
        _oldPasswordField.returnKeyType = UIReturnKeyNext;
        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"登录密码   ";
        [label sizeToFit];
        _oldPasswordField.leftView = label;
        _oldPasswordField.leftViewMode=UITextFieldViewModeAlways;
        
    }
    return  _oldPasswordField;
}

- (UILabel *)middleLable
{
    if (!_middleLable) {
        _middleLable  = [UILabel new];
        _middleLable.font = [UIFont systemFontOfSize:14];
        _middleLable.textColor = [UIColor colorWithHexString:@"999999"];
        _middleLable.text = @"请重新设置新密码";
    }
    return _middleLable;
}

- (UITextField *)newPasswordField
{
    if (!_newPasswordField) {
        _newPasswordField = [[LoginTextField alloc] init];
        _newPasswordField.placeholder = @"6-8位字母/数字组合";
        _newPasswordField.keyboardType = UIKeyboardTypeNumberPad;
        _newPasswordField.returnKeyType = UIReturnKeyNext;
        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"设置新密码   ";
        [label sizeToFit];
        _newPasswordField.leftView = label;
        _newPasswordField.leftViewMode=UITextFieldViewModeAlways;
        
    }
    return  _newPasswordField;
}

- (UITextField *)new2PasswordField
{
    if (!_new2PasswordField) {
        _new2PasswordField = [[LoginTextField alloc] init];
        _new2PasswordField.placeholder = @"再次填写新密码";
        _new2PasswordField.keyboardType = UIKeyboardTypeNumberPad;
        _new2PasswordField.returnKeyType = UIReturnKeyNext;
        UILabel *label  = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"333333"];
        label.text = @"确认新密码   ";
        [label sizeToFit];
        _new2PasswordField.leftView = label;
        _new2PasswordField.leftViewMode=UITextFieldViewModeAlways;
        
    }
    return  _new2PasswordField;
}

- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.backgroundColor = COLOR_O;
        [_doneButton setTitle:@"提  交" forState:0];
        [_doneButton setTitle:@"提  交" forState:UIControlStateDisabled];
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

@end
