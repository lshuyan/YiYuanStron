//
//  OptionTableViewCell.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/22.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "OptionTableViewCell.h"
#import "OptionItme.h"
#import "OptionModel.h"

#import "UIColor+Extern.h"

@interface OptionTableViewCell ()

@property (nonatomic, strong)UILabel                                     *topLabel;
@property (nonatomic, strong)UIView                                      *mainView;
@property (nonatomic, strong)UIView                                      *lineView;

@property (nonatomic, strong)OptionCellModel                        *model;

@end

@implementation OptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.topLabel];
    [self.contentView addSubview:self.mainView];
    [self.contentView addSubview:self.lineView];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(8));
        make.left.equalTo(@15);
    }];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.left.equalTo(@(15));
        make.top.equalTo(self.topLabel.mas_bottom).offset(7);
        make.bottom.equalTo(@(-9));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.left.equalTo(@(15));
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

#pragma mark ------------- set get

- (void)makeCellForModel:(OptionCellModel *)model
{
    self.topLabel.text = model.title;
    self.model = model;
    switch (self.model.optionTableViewCellStyle) {
        case OptionTableViewCellStyleDefault:
            [self makeOptionTableViewCellStyleDefault];
            break;
        case OptionTableViewCellStyleValueLong:
            [self makeOptionTableViewCellStyleValueLong];
            break;
        default:
            break;
    }
}

- (void)makeOptionTableViewCellStyleDefault
{
    for (UIView *view in self.mainView.subviews) {
        [view removeFromSuperview];
    }
    for (int i = 0 ; i < self.model.arrModels.count; i++) {
        OptionModel *model = self.model.arrModels[i];
        OptionItme *itme = [OptionItme buttonWithType:UIButtonTypeCustom];
        itme.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:itme];
        [itme setTitle:model.title forState:0];
        [[itme rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(OptionItme *time) {
            NSLog(@"%@ ===  %@", time.titleLabel.text, model.title);
        }];
        [itme mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@(80 * kSCREEN_6));
            make.height.equalTo(@(26 * kSCREEN_6));
            if (i%2 == 0) {
                make.left.equalTo(@0);
            }else if(i%2 == 1)
            {
                make.centerX.equalTo(@0);
            }else if(i%2 == 2)
            {
                make.right.equalTo(@0);
            }
        }];
    }
}

- (void)makeOptionTableViewCellStyleValueLong
{
    for (UIView *view in self.mainView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0 ; i < self.model.arrModels.count; i++) {
        OptionModel *model = self.model.arrModels[i];
        int section = i/2;
        OptionItme *itme = [OptionItme buttonWithType:UIButtonTypeCustom];
        itme.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.mainView addSubview:itme];
        [itme setTitle:model.title forState:0];
        [[itme rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(OptionItme *time) {
            NSLog(@"%@ ===  %@", time.titleLabel.text, model.title);
        }];
        [itme mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(section*(9+26 * kSCREEN_6)));
            make.width.equalTo(@(135 * kSCREEN_6));
            make.height.equalTo(@(26 * kSCREEN_6));
            if (i%2 == 0) {
                make.left.equalTo(@0);
            }else if(i%2 == 1)
            {
                make.right.equalTo(@0);
            }
            
            if (i == self.model.arrModels.count-1) {
                make.bottom.equalTo(@0);
            }
        }];
    }
    
}

#pragma mark ------------- set get

- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [UILabel new];
        _topLabel.font = [UIFont systemFontOfSize:17];
        _topLabel.backgroundColor = [UIColor clearColor];
        _topLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    }
    return _topLabel;
}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.backgroundColor = [UIColor clearColor];
    }
    return _mainView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.alpha = 0.15;
    }
    return _lineView;
}


@end
