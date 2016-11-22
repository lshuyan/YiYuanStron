//
//  BasicTableViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/21.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "BasicTableViewController.h"

@interface BasicTableViewController ()

@end

@implementation BasicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(@0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    }
    return _tableView;
}


@end
