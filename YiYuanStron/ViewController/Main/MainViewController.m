//
//  MainViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MainViewController.h"
#import "BannerScrollView.h"

@interface MainViewController ()

@property (nonatomic, strong) BannerScrollView *bannerScrollView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:UIBarButtonItemStyleDone target:self action:@selector(onTouchLeftItme)];
//    self.navigationController.navigationItem.leftBarButtonItem = itme;
    
    [self addBannerScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addBannerScrollView
{
    [self.view addSubview:self.bannerScrollView];
    [self.bannerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@200);
    }];
}

- (BannerScrollView *)bannerScrollView
{
    if (!_bannerScrollView) {
        _bannerScrollView = [[BannerScrollView alloc] init];
        NSMutableArray *arr =[[NSMutableArray alloc] initWithCapacity:2];
        for (int i = 0; i < 5; i++) {
            BannerItemModel *model = [[BannerItemModel alloc] initWithDictionary:@{@"bannerImg":[NSString stringWithFormat:@"%d%d%d%d%d%d", i*2, i*2, i*2, i*2, i*2, i*2]} error:nil];
            [arr addObject:model];
        }
        [_bannerScrollView makeForItemModels:arr callBackBlock:^(BannerItemModel *model) {
            UIViewController *controller = [[UIViewController alloc] init];
            controller.view.backgroundColor = [UIColor orangeColor];
//            controller.view.clipsToBounds=YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }];
    }
    return _bannerScrollView;
}
@end
