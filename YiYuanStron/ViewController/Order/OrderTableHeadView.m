//
//  OrderTableHeadView.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/23.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "OrderTableHeadView.h"

@interface OrderTableHeadView ()

@property(nonatomic, strong) UIImageView         *addressImageView;

@property(nonatomic, strong) UIImageView         *productImageView;
@property(nonatomic, strong) UILabel                  *productLabel;
@property(nonatomic, strong) UIView                  *progressView;//进度条
@property(nonatomic, strong) UILabel                  *totalLabel;
@property(nonatomic, strong) UILabel                  *willNeedLabel;
@property(nonatomic, strong) UILabel                  *priceLabel;
@property(nonatomic, strong) UILabel                  *onceLabel;



@end

@implementation OrderTableHeadView

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
    [self addSubview:self.addressContentView];
    [self.addressContentView addSubview:self.addressImageView];
    [self.addressContentView addSubview:self.userAddressView];
    UIView *line1 = [self createLineView];
    [self.addressContentView addSubview:line1];
    
    [self addSubview:self.productContentView];
    [self.productContentView addSubview:self.productImageView];
    [self.productContentView addSubview:self.productLabel];
    [self.productContentView addSubview:self.progressView];
    [self.productContentView addSubview:self.totalLabel];
    [self.productContentView addSubview:self.willNeedLabel];
    [self.productContentView addSubview:self.priceLabel];
    [self.productContentView addSubview:self.onceLabel];
    UIView *line2 = [self createLineView];
    [self.productContentView addSubview:line2];
    
    [self.addressContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
    }];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@15);
        make.height.equalTo(@29);
        make.width.equalTo(@29);
    }];
    [self.userAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressImageView.mas_right).offset(15);
        make.right.equalTo(@(-15));
        make.top.equalTo(@9);
        make.bottom.equalTo(@(-10));
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(@(-15));
        make.left.equalTo(@(15));
        make.height.equalTo(@1);
    }];
    
    [self.productContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
//        make.width.equalTo(@(kSCREEN_WIGHT));
        make.top.equalTo(self.addressContentView.mas_bottom);
    }];
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@15);
        make.bottom.equalTo(@(-15));
        make.width.height.equalTo(@88);
    }];
    //
    [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(14);
        make.right.equalTo(@(-15));
        make.top.lessThanOrEqualTo(@16);
        make.bottom.equalTo(self.progressView.mas_top).offset(-5);
    }];
    self.productImageView.backgroundColor = [UIColor greenColor];
    self.progressView.backgroundColor = [UIColor greenColor];
    self.productLabel.backgroundColor = [UIColor orangeColor];
    self.productLabel.text = @"［第一期］商品名商品名商品名商品名商品名商品名";
    self.totalLabel.text = @"总需100人次";
    self.willNeedLabel.text = @"还需40人次";
    self.priceLabel.text = @"10白积分";
    self.onceLabel.text = @"x1";

    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(14);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(14));
        make.centerY.equalTo(self.productImageView);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(14);
        make.top.equalTo(self.progressView.mas_bottom).offset(5);
    }];
    [self.willNeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.totalLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.mas_right).offset(14);
        make.bottom.equalTo(self.productImageView.mas_bottom);
    }];
    [self.onceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.bottom.equalTo(self.productImageView.mas_bottom);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma mark ------------- set get

- (UIView *)addressContentView
{
    if (!_addressContentView) {
        _addressContentView = [UIView new];
    }
    return _addressContentView;
}

- (UserAddressView *)userAddressView
{
    if (!_userAddressView) {
        _userAddressView = [[UserAddressView alloc] init];
        _userAddressView.nameLabel.text = @"收货人:张三";
        _userAddressView.numberLabel.text = @"4567890";
        _userAddressView.addressLabel.text = @"收货地址:广州市番禺区厦溶南路信基中创空间空间空间空间空间空间空间空间空间空间空间空间空间";
    }
    return _userAddressView;
}

- (UIImageView *)addressImageView
{
    if (!_addressImageView) {
        _addressImageView = [UIImageView new];
        _addressImageView.image = [UIImage imageNamed:@"cell_address"];
        _addressImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _addressImageView;
}

- (UIView *)productContentView
{
    if (!_productContentView) {
        _productContentView = [UIView new];
    }
    return _productContentView;
}

- (UIImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = [UIImageView new];
        _productImageView.image = [UIImage imageNamed:@"cell_address"];
        _productImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _productImageView;
}

- (UILabel *)productLabel
{
    if (!_productLabel) {
        _productLabel = [UILabel new];
        _productLabel.font = [UIFont systemFontOfSize:15];
        _productLabel.textColor = [UIColor colorWithHexString:@"030303"];
    }
    return _productLabel;
}

- (UIView *)progressView
{
    if (!_progressView) {
        _progressView = [UIView new];
        _progressView.backgroundColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (UILabel *)totalLabel
{
    if (!_totalLabel) {
        _totalLabel = [UILabel new];
        _totalLabel.font = [UIFont systemFontOfSize:14];
        _totalLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _totalLabel;
}

- (UILabel *)willNeedLabel
{
    if (!_willNeedLabel) {
        _willNeedLabel = [UILabel new];
        _willNeedLabel.font = [UIFont systemFontOfSize:14];
        _willNeedLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _willNeedLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _priceLabel;
}

- (UILabel *)onceLabel
{
    if (!_onceLabel) {
        _onceLabel = [UILabel new];
        _onceLabel.font = [UIFont systemFontOfSize:12];
        _onceLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _onceLabel;
}

- (UIView *)createLineView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"e1e2e3"];
    return view;
}

@end
