//
//  userAddressView.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/23.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "userAddressView.h"
#import "UIColor+Extern.h"

@interface UserAddressView ()


@end

@implementation UserAddressView

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
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.numberLabel];
    [self addSubview:self.addressLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(@0);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
   
}

#pragma mark ------------- set get

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"000000"];
    }
    return _nameLabel;
}

- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [UILabel new];
        _numberLabel.font = [UIFont systemFontOfSize:15];
        _numberLabel.textColor = [UIColor colorWithHexString:@"666666"];
    }
    return _numberLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _addressLabel.numberOfLines = 2;
        _addressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLabel;
}

@end
