//
//  OptionViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/22.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "OptionViewController.h"
#import "UIColor+Extern.h"
#import "OptionTableViewCell.h"
#import "OptionModel.h"

static NSString *kOptionCellIdentifier = @"kOptionCellIdentifier";

static NSString *kTopLabel= @"kTopLabel";
static NSString *kContentSouce= @"kContentSouce";


@interface OptionViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTableVIew];
    [self addImageBackground];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCellModel *model = self.arrDataSouce[indexPath.row];
    if (model.optionTableViewCellStyle == OptionTableViewCellStyleDefault) {
        return 73;
    }else {
        int a = 73 + (int)(model.arrModels.count/2.0 +0.5 -1)*35;
        NSLog(@" %d", a);
        return  73 + (int)(model.arrModels.count/2.0 +0.5 -1)*35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOptionCellIdentifier];
    if (!cell) {
        cell = [self createUITableViewCell];
    }
    OptionCellModel *model = self.arrDataSouce[indexPath.row];
    [cell makeCellForModel:model];
    NSLog(@" %@", model.title);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------------- private

- (void)makeTableVIew
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
//    self.arrDataSouce  = [[NSMutableArray alloc] init];
    NSArray<OptionCellModel *> *arr = @[
                           @{
                               @"title":@" 积分购物",
                               @"arrModels":@[@{@"title":@"人气最高"}, @{@"title":@"积分最低"}, @{@"title":@"积分最高"}],
                               @"optionTableViewCellStyle":@"0"
                               },
                           @{
                               @"title":@" 组合购物",
                               @"arrModels":@[@{@"title":@"10%红积分+90%白积分"},
                                              @{@"title":@"10%红积分+90%白积分"},
                                              @{@"title":@"10%红积分+90%白积分"},@{@"title":@"10%红积分+90%白积分"},@{@"title":@"10%红积分+90%白积分"},@{@"title":@"10%红积分+90%白积分"},@{@"title":@"10%红积分+90%白积分"},
  @{@"title":@"10%红积分+90%白积分"}],
                               
                               @"optionTableViewCellStyle":@"1"
                               },
                           @{
                               @"title":@" 购物",
                               @"arrModels":@[@{@"title":@"人气最高"}, @{@"title":@"积分最低"}, @{@"title":@"积分最高"}],
                               @"optionTableViewCellStyle":@"0"
                               },
                           @{
                               @"title":@" 积分夺宝",
                               @"arrModels":@[@{@"title":@"人气最高"}, @{@"title":@"积分最低"}, @{@"title":@"积分最高"}],
                               @"optionTableViewCellStyle":@"0"
                               },
                           @{
                               @"title":@" 积分夺宝",
                               @"arrModels":@[@{@"title":@"人气最高"}, @{@"title":@"积分最低"}, @{@"title":@"积分最高"}],
                               @"optionTableViewCellStyle":@"0"
                               },
                           @{
                               @"title":@" 组合夺宝",
                               @"arrModels":@[@{@"title":@"10%红积分+90%白积分"},
//  @{@"title":@"10%红积分+90%白积分"},
  @{@"title":@"10%红积分+90%白积分"}],
                               @"optionTableViewCellStyle":@"1"
                               },
                           
                           ] ;
    self.arrDataSouce  = [[OptionCellModel arrayOfModelsFromDictionaries:arr error:nil] mutableCopy];

}

- (void)addImageBackground
{
    UIImageView *imageView = [UIImageView new];
//    imageView.image = [[UIImage imageNamed:@"leftbar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,0,1,1344)];
    imageView.image = [[UIImage imageNamed:@"leftbar_bg.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1344];
    [self.view insertSubview:imageView atIndex:0];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
}

- (OptionTableViewCell *)createUITableViewCell
{
    OptionTableViewCell *cell = [[OptionTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kOptionCellIdentifier];
    
    return cell;
}

@end
