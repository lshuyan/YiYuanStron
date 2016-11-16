//
//  LeftViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/8.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "LeftViewController.h"

static NSString *kLeftViewControllerCellIdentifier = @"LeftViewControllerCellIdentifier";

@interface LeftViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, copy)NSMutableArray              *arrDataSouce;

@property(nonatomic, strong)UITableView                 *tableView;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES];
    self.arrDataSouce =  [NSMutableArray arrayWithArray:@[@"百度",@"apple"]];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.top.equalTo(@200);
        make.width.equalTo(self.view).multipliedBy(0.8);
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ------------- set get

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIGHT, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kLeftViewControllerCellIdentifier];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark ------------- tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDataSouce.count;
}
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLeftViewControllerCellIdentifier];
    cell.textLabel.text = self.arrDataSouce[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BasicViewController *controller = [[BasicViewController alloc] init];
    controller.view.backgroundColor = [UIColor orangeColor];
    [controller mainNavController];
    [controller addNavBackItme];
    //            controller.view.clipsToBounds=YES;
    [self presentViewController:controller animated:YES completion:nil];
}
@end
