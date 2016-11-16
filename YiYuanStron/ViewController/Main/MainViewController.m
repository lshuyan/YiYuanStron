//
//  MainViewController.m
//  YiYuanStron
//
//  Created by ybjy on 16/11/1.
//  Copyright © 2016年 huyan. All rights reserved.
//

#import "MainViewController.h"
#import "BannerScrollView.h"
#import "MenuScrollView.h"

@interface MainViewController ()

@property (nonatomic, strong) BannerScrollView      *bannerScrollView;
@property (nonatomic, strong) MenuScrollView        *menuScrollVIew;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kAppTitle;
    
    [self addMenuScorllView];
    [self addBannerScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addBannerScrollView
{
    [self.view addSubview:self.bannerScrollView];
    [self.bannerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@44);
        make.height.equalTo(@200);
    }];
}

- (void)addMenuScorllView
{
    [self.view addSubview:self.menuScrollVIew];
    [self.menuScrollVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@44);
    }];
}

#pragma mark -------------  set get

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
            BasicViewController *controller = [[BasicViewController alloc] init];
            controller.view.backgroundColor = [UIColor orangeColor];
            [controller addNavBackItme];
//            controller.view.clipsToBounds=YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }];
    }
    return _bannerScrollView;
}

- (MenuScrollView *)menuScrollVIew
{
    if (!_menuScrollVIew) {
        _menuScrollVIew = [[MenuScrollView alloc] init];
        NSArray *arr = @[@"点点滴都滴1", @"江诗丹顿1", @"江诗顿1", @"丹顿1", @"江诗丹顿1", @"江诗丹顿1", @"1江诗丹顿"];
//        NSArray *arr2= @[@"点点滴都滴", @"江诗丹顿", @"江诗顿", @"丹顿"];
//        NSArray *arr2 = @[@"点点滴都滴", @"江诗丹顿"];

        NSMutableArray *arrModel =[[NSMutableArray alloc] initWithCapacity:2];
        for (int i = 0; i < arr.count; i++) {
            MenuItmeModel *model = [[MenuItmeModel alloc] init];
            model.title = arr[i];
            [arrModel addObject:model];
        }
        [_menuScrollVIew makeForItemModels:arrModel callBackBlock:^(MenuItmeModel *model) {
            NSLog(@"%@ --------------------",  model.title);
            
        }];
        
    }
    return _menuScrollVIew;
}

@end
