//
//  LoginViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/10/27.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+Extern.h"
#import "UIView+Animations.h"
#import "LoginTextField.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView                  *mainView;  // 底
@property (nonatomic, strong)UIImageView        *backImageView; //底图
@property (nonatomic, strong)LoginTextField      *userNameField; //账号
@property (nonatomic, strong)LoginTextField      *passwordField; //密码
@property (nonatomic, strong)UIButton                *injoyButton; //登录
@property (nonatomic, strong)UIButton                *storeDelegateButton; //协议
@property (nonatomic, strong)UIView                  *storeDelegateView; //装协议按钮
@property (nonatomic, strong)UIButton                *registerButton; //注册
@property (nonatomic, strong)UIButton                *forgetPasswordButton; //忘记密码
@property (nonatomic, strong)UIView                  *verticalLineView; //竖线
@property (nonatomic, strong)UIButton                *backButton; //放回
@property (nonatomic, strong)UIButton                  *errerButton; //错我提示

@property (nonatomic, copy)NSString                 *userName; //账号
@property (nonatomic, copy)NSString                 *password; //密码
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.userNameField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.injoyButton];
    [self.view addSubview:self.storeDelegateView];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.forgetPasswordButton];
    [self.view addSubview:self.verticalLineView];
    [self.view addSubview:self.errerButton];
    [self.view addSubview:self.backButton];

    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(@0);
    }];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@(356*kSCREEN_6));
    }];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25*kSCREEN_6));
        make.right.equalTo(@(-25*kSCREEN_6));
        make.height.equalTo(@(34));
        if (isIphoneLess_6) {
            make.top.equalTo(@(208*kSCREEN_6)); //如果是5或者4的设备, 有遮住输入框的可能, 往上了一点点
        }else
        {
            make.top.equalTo(@(228*kSCREEN_6));
        }
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25*kSCREEN_6));
        make.right.equalTo(@(-25*kSCREEN_6));
        make.height.equalTo(@(34));
        make.top.equalTo(self.userNameField.mas_bottom).offset(18*kSCREEN_6);
    }];
    [self.injoyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15*kSCREEN_6));
        make.right.equalTo(@(-15*kSCREEN_6));
        make.height.equalTo(@(42));
        make.top.equalTo(self.passwordField.mas_bottom).offset(24*kSCREEN_6);
    }];
    [self.storeDelegateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.injoyButton.mas_bottom).offset(10*kSCREEN_6);
    }];
    //竖线
    [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@1);
        make.centerX.equalTo(@0);
        make.height.equalTo(@14);
        make.bottom.equalTo(@(-50 * kSCREEN_6));
    }];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verticalLineView.mas_centerY);
        make.right.equalTo(self.verticalLineView.mas_left).offset(-12 * kSCREEN_6);
    }];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verticalLineView.mas_centerY);
        make.left.equalTo(self.verticalLineView.mas_right).offset(12 * kSCREEN_6);
    }];
    //错误提示
    [self.errerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameField.mas_left);
        make.bottom.equalTo(self.userNameField.mas_top).offset(-10 * kSCREEN_6);
    }];
    //返回
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- 代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userNameField) {
        [self.passwordField becomeFirstResponder];
    } else {
        
    }
    return YES;
}

#pragma mark ------------- 重写

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark ------------- 私有事件

/**
 *    账号密码错误提示文字
 **/
- (void)showErrerLabel
{
    self.errerButton.hidden = NO;
    [self.errerButton startTransitionAnimation];
}

#pragma mark ------------- 点击事件

/**
 *    登录按钮事件
 **/
- (void)onClickInjoyButtion
{
    [self.view endEditing:YES];
    [self showErrerLabel];
    NSLog(@"onClickInjoyButtion");
}

/**
 *    协议
 **/
- (void)onClickStoreDelegat
{
    [self.view endEditing:YES];
    NSLog(@"onClickStoreDelegat");

}

/**
 *    注册
 **/
- (void)onClickFreeRegister
{
    [self.view endEditing:YES];
    NSLog(@"onClickFreeRegister");

}

/**
 *    忘记密码
 **/
- (void)onClickForgetPassword
{
    [self.view endEditing:YES];
    NSLog(@"onClickForgetPassword");

}

#pragma mark ------------- set get

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
    }
    return _mainView;
}

- (UIImageView *)backImageView
{
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backImageView.image = [UIImage imageNamed:@"login_background"];
    }
    return _backImageView;
}

- (UITextField *)userNameField
{
    if (!_userNameField) {
        _userNameField = [[LoginTextField alloc] init];
        _userNameField.placeholder = @"请输入您的手机号/易源账号";
        _userNameField.keyboardType = UIKeyboardTypeDefault;
        _userNameField.returnKeyType = UIReturnKeyNext;
    }
    return  _userNameField;
}

- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[LoginTextField alloc] init];
        _passwordField.placeholder = @"请输入登录密码";
        _passwordField.keyboardType = UIKeyboardTypeDefault;
        _passwordField.returnKeyType = UIReturnKeyJoin;
        _passwordField.secureTextEntry = YES;
    }
    return  _passwordField;
}

- (UIButton *)injoyButton
{
    if (!_injoyButton) {
        _injoyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _injoyButton.backgroundColor = COLOR_O;
        [_injoyButton setTitle:@"登  录" forState:0];
        [_injoyButton setTitleColor:[UIColor colorWithHexString:@"ffffff" alpha:0.6] forState:0];
        _injoyButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_injoyButton addTarget:self action:@selector(onClickInjoyButtion) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _injoyButton;
}

- (UIButton *)storeDelegateButton
{
    if (!_storeDelegateButton) {
        _storeDelegateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _storeDelegateButton.backgroundColor = [UIColor clearColor];
        _storeDelegateButton.titleLabel.font = [UIFont systemFontOfSize:12];
        NSString  *string = @"《易源商城》协议";
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange titleRange = {0,[title length]};
        NSRange range1 = [string rangeOfString:@"《易源商城》"];
        NSRange range2 = [string rangeOfString:@"协议"];
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:COLOR_G range:range1];
        [title addAttribute:NSForegroundColorAttributeName value:COLOR_B range:range2];
        [_storeDelegateButton setAttributedTitle:title
                          forState:UIControlStateNormal];
        [_storeDelegateButton setTitleColor:COLOR_G forState:0];
        [_storeDelegateButton addTarget:self action:@selector(onClickStoreDelegat) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _storeDelegateButton;
}

- (UIView *)storeDelegateView
{
    if (!_storeDelegateView) {
        _storeDelegateView = [UIView new];
        _storeDelegateView.backgroundColor = [UIColor clearColor];
        _storeDelegateView.userInteractionEnabled = YES;
        
        UILabel *label = [UILabel new];
        label.text = @"说明：注册/登录代表你已同意";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithHexString:@"999999"];
        [_storeDelegateView addSubview:label];
        [_storeDelegateView addSubview:self.storeDelegateButton];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
        }];
        [self.storeDelegateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(@0);
            make.left.equalTo(label.mas_right);
        }];
    }
    return _storeDelegateView;
}

- (UIButton *)registerButton
{
    if (!_registerButton) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerButton setTitle:@"免费注册" forState:0];
        [_registerButton setTitleColor: [UIColor colorWithHexString:@"999999"] forState:0];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton addTarget:self action:@selector(onClickFreeRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _registerButton;
}

- (UIButton *)forgetPasswordButton
{
    if (!_forgetPasswordButton) {
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitle:@"忘记密码" forState:0];
        [_forgetPasswordButton setTitleColor: [UIColor colorWithHexString:@"999999"] forState:0];
        _forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetPasswordButton addTarget:self action:@selector(onClickForgetPassword) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _forgetPasswordButton;
}

- (UIView *)verticalLineView
{
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc] init];
        _verticalLineView.userInteractionEnabled = NO;
        _verticalLineView.backgroundColor = [UIColor colorWithHexString:@"d8d8d8"];
    }
    return _verticalLineView;
}

- (UIButton *)errerButton
{
    if (!_errerButton) {
        _errerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_errerButton setImage:[UIImage imageNamed:@"login_errer_X.png"] forState:0];
        [_errerButton setTitle:@"请输入正确的用户名和密码" forState:0];
        [_errerButton setTitleColor: [UIColor colorWithHexString:@"f32f00"] forState:0];
        _errerButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _errerButton.hidden = YES;
        _errerButton.userInteractionEnabled = NO;
    }
    return _errerButton;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"login_back.png"] forState:0];
        @weakify(self)
        [[_backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self_weak_ backToViewController];
        }];
    }
    return _backButton;
}

@end
