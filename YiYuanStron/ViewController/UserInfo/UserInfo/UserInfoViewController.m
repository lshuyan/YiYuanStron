//
//  UserInfoViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/18.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIColor+Extern.h"

static NSString *kUserInfoCellIdentifier = @"kUserInfoCellIdentifier";

static NSString *kLeftLabel= @"kLeftLabel";
static NSString *kRightLabel= @"kRightLabel";
static NSString *kRightImageView= @"kRightImageView";
static NSString *kIsHideRightImageView= @"kIsHideRightImageView";
static NSString *kAccessoryImageView= @"kAccessoryImageView";

@interface UserInfoCell: UITableViewCell

@property (nonatomic, strong)UILabel                         *leftLabel;
@property (nonatomic, strong)UILabel                         *rightLabel;
@property (nonatomic, strong)UIImageView                *rightImageView;
@property (nonatomic, strong)UIImageView                *accessoryImageView;
@end

@implementation UserInfoCell

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
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.accessoryImageView];

    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15 ));
        make.centerY.equalTo(@0);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-33));
        make.centerY.equalTo(@0);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-33));
        make.centerY.equalTo(@0);
        make.width.height.equalTo(@29);
    }];
    [self.accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(@0);
    }];
}

#pragma mark ------------- set get

- (UILabel *)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.font = [UIFont systemFontOfSize:17];
        _leftLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = [UIColor colorWithHexString:@"999999"];
    }
    return _rightLabel;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [UIImageView new];
        _rightImageView.backgroundColor = [UIColor colorWithHexString:@"999999"];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _rightImageView;
}

- (UIImageView *)accessoryImageView
{
    if (!_accessoryImageView) {
        _accessoryImageView = [UIImageView new];
        _accessoryImageView.image = [UIImage imageNamed:@"cellAccessoryRight"];
        _accessoryImageView.contentMode = UIViewContentModeScaleAspectFill;

    }
    return _accessoryImageView;
}

@end

@interface UserInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView                       *tableView;

@property(nonatomic, copy)NSMutableArray                    *arrDataSouce;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(@0);
    }];
    
    self.arrDataSouce = [@[
                           @{
                               kLeftLabel:@"头像",
                               kRightLabel:@"",
                               kRightImageView:@"",
                               kIsHideRightImageView:@(NO),
                             },
                           @{
                               kLeftLabel:@"昵称",
                               kRightLabel:@"积分夺宝会员",
                               kRightImageView:@"",
                               kIsHideRightImageView:@(YES),
                               },
                           @{
                               kLeftLabel:@"会员账号",
                               kRightLabel:@"152345",
                               kRightImageView:@"",
                               kIsHideRightImageView:@(YES),
                               },
                           @{
                               kLeftLabel:@"手机号码",
                               kRightLabel:@"1394934512",
                               kRightImageView:@"",
                               kIsHideRightImageView:@(YES),
                               },
                           @{
                               kLeftLabel:@"实名认证",
                               kRightLabel:@"",
                               kRightImageView:@"",
                               kIsHideRightImageView:@(YES),
                               },
                           
                           ] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------- tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDataSouce.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kUserInfoCellIdentifier];
    NSDictionary *dic = self.arrDataSouce[indexPath.row];
    cell.leftLabel.text = dic[kLeftLabel];
    cell.rightLabel.text = dic[kRightLabel];
    cell.rightLabel.hidden = [dic[kRightLabel] isEqualToString:@""];
    cell.rightImageView.hidden = [dic[kIsHideRightImageView] boolValue];
    cell.rightImageView.image = [UIImage imageNamed:dic[kRightImageView]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark ------------- set get

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UserInfoCell class] forCellReuseIdentifier:kUserInfoCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
