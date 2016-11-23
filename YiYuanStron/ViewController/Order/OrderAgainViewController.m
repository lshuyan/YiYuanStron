//
//  OrderAgainViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/23.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "OrderAgainViewController.h"
#import "OrderTableHeadView.h"

@interface OrderAgainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)OrderTableHeadView                *headView;

@end

@implementation OrderAgainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self addNavBackItme];
    
    [self makeTableVIew];
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
    [self.headView layoutIfNeeded];
    NSLog(@"%f", self.headView.productContentView.bottom);
    return self.headView.productContentView.bottom;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
//    if (!cell) {
//        cell = [self createUITableViewCell];
//    }
//    NSDictionary *dic = self.arrDataSouce[indexPath.row];
//    cell.textLabel.text = dic[kLeftLabel];
//    cell.imageView.image = [UIImage imageNamed:dic[kLeftImageView]];
    return cell;
}

#pragma mark ------------- private

- (void)makeTableVIew
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.arrDataSouce = [@[
//                           @{
//                               kLeftLabel:@" 地址管理",
//                               kLeftImageView:@"leftbar_ icon_addres management_ nor_",
//                               },
//                           @{
//                               kLeftLabel:@"转增积分",
//                               kLeftImageView:@"leftbar_ icon_transfer integral_ nor_",
//                               },
//                           @{
//                               kLeftLabel:@"分户管理",
//                               kLeftImageView:@"leftbar_ icon_household management_ nor_",
//                               },
//                           @{
//                               kLeftLabel:@"设置",
//                               kLeftImageView:@"leftbar_ icon_set up_ nor_",
//                               }
//                           
//                           ] mutableCopy];
}

#pragma mark ------------- set get

- (OrderTableHeadView *)headView
{
    if (!_headView) {
        _headView = [[OrderTableHeadView alloc] init];
    }
    return _headView;
}

@end
