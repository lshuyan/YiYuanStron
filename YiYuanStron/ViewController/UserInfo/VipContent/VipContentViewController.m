//
//  VipContentViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/21.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "VipContentViewController.h"
#import "UIImage+FitSize.h"
#import "UIColor+Extern.h"

static NSString *kVipContentCellIdentifier = @"kVipContentCellIdentifier";

static NSString *kLeftLabel= @"kLeftLabel";
static NSString *kLeftImageView= @"kRightImageView";
//static NSString *kRightLabel= @"kRightLabel";
//static NSString *kIsHideRightImageView= @"kIsHideRightImageView";
//static NSString *kAccessoryImageView= @"kAccessoryImageView";

@interface VipContentViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation VipContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTableVIew];
    [self addImageBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDataSouce.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kVipContentCellIdentifier];
    if (!cell) {
        cell = [self createUITableViewCell];
    }
    NSDictionary *dic = self.arrDataSouce[indexPath.row];
    cell.textLabel.text = dic[kLeftLabel];
    cell.imageView.image = [UIImage imageNamed:dic[kLeftImageView]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------------- private

- (void)makeTableVIew
{
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.top.equalTo(@0);
//    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.arrDataSouce = [@[
                           @{
                               kLeftLabel:@" 地址管理",
                               kLeftImageView:@"leftbar_ icon_addres management_ nor_",
                               },
                           @{
                               kLeftLabel:@"转增积分",
                               kLeftImageView:@"leftbar_ icon_transfer integral_ nor_",
                               },
                           @{
                               kLeftLabel:@"分户管理",
                               kLeftImageView:@"leftbar_ icon_household management_ nor_",
                               },
                           @{
                               kLeftLabel:@"设置",
                               kLeftImageView:@"leftbar_ icon_set up_ nor_",
                               }
                           
                           ] mutableCopy];

}

- (void)addImageBackground
{
    UIImageView *imageView = [UIImageView new];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    stretchableImageWithLeftCapWidth
    imageView.image = [[UIImage imageNamed:@"leftbar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,1,1344)];
//    [self.view insertSubview:imageView atIndex:0];
    imageView.image = [[UIImage imageNamed:@"leftbar_bg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1344];
    [self.view insertSubview:imageView atIndex:0];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
}


- (UITableViewCell *)createUITableViewCell
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kVipContentCellIdentifier];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.textColor  = [UIColor colorWithHexString:@"ffffff" alpha:.5];
    
    UIImageView *accessoryImageView = [UIImageView new];
    accessoryImageView.image = [UIImage imageNamed:@"vip_cell_accessory"];
    accessoryImageView.contentMode = UIViewContentModeScaleAspectFill;
    [cell.contentView addSubview:accessoryImageView];
    [accessoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(@0);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.15;
    [cell.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.left.equalTo(cell.textLabel);
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    
    return cell;
}

@end
